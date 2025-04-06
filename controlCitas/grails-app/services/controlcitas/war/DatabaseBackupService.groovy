package controlcitas.war

import grails.transaction.Transactional
import grails.util.Holders
import java.util.zip.ZipOutputStream
import java.util.zip.ZipEntry

@Transactional
class DatabaseBackupService {

    def grailsApplication

    def serviceMethod() {

	}

    def myFunction() {
        return 'my function'
    }

    def createBackupZip() {
        println 'We are going to init'
        def config = grailsApplication.config      
        def dbName = config.dataSource.dbName
        def dbUser = config.dataSource.username
        def dbPassword = config.dataSource.password
        def backupDir = "/tmp/db_backups"
        println 'getting backupDir ' + backupDir
        new File(backupDir).mkdirs()

        def timestamp = new Date().format("yyyyMMdd_HHmmss")
        def sqlFilePath = "${backupDir}/backup-${timestamp}.sql"
        def zipFilePath = "${backupDir}/backup-${timestamp}.zip"

        println 'Beging backup '
        // TODO make configurable the mysql OR in every PC put mysql in the global
        def dumpCommand = "mysqldump -u${dbUser} -p${dbPassword} ${dbName} > ${sqlFilePath}"
        def process = ["bash", "-c", dumpCommand].execute()
        println 'Ending backup '
        process.waitFor()

        if (process.exitValue() != 0) {
            throw new RuntimeException("Backup failed: ${process.err.text}")
        }

        println 'Beging compressing in zip '
        // Zip the file
        def zipFile = new File(zipFilePath)
        def sqlFile = new File(sqlFilePath)

        zipFile.withOutputStream { fos ->
            new ZipOutputStream(fos).withCloseable { zos ->
                zos.putNextEntry(new ZipEntry(sqlFile.name))
                sqlFile.withInputStream { is -> zos << is }
                zos.closeEntry()
            }
        }
        println 'Ending compressing in zip '

        // Optional: delete raw .sql after zipping
        sqlFile.delete()

        return zipFile
    }
}