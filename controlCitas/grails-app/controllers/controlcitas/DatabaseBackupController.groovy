package controlcitas

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class DatabaseBackupController {

    def DatabaseBackupService
    def PruebaService
    // def s3UploadService // We'll define it in Step 3

    def index(Integer max) {
    }

    def otraCosa() {
        println 'Otra Cosa ' + PruebaService.foo()
    }

    def downloadBackup() {
        try {
            File zipFile = DatabaseBackupService.createBackupZip()

            // Upload to S3 in the background (optional: make async if needed)
            // s3UploadService.uploadFile(zipFile)

            // Send file as response
            response.setContentType("application/zip")
            response.setHeader("Content-Disposition", "attachment; filename=${zipFile.name}")
            response.outputStream << zipFile.newInputStream()
            response.outputStream.flush()

            // Optionally delete after sending
            zipFile.delete()
        } catch (Exception e) {
            println "Error here"
            render status: 500, text: "Backup failed: ${e.message}"
        }
    }
}
