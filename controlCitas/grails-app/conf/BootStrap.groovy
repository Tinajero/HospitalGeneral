import controlcitas.*

import groovy.sql.Sql

class BootStrap {
	def springSecurityService
	def grailsApplication
	
    def init = { servletContext ->

		def adminRole = new SecRole(authority: 'ROLE_ADMIN').save(flush:true)
		def userRole = new SecRole(authority: 'ROLE_USER').save(flush:true)
		
		def testUser = new Usuario(username: 'administrador', password: 'password')
		def testUser2 = new Usuario(username: 'maria', password: 'maria')
		def userUser = new Usuario(username: 'usuario', password: 'notiene')
		testUser.save(flush:true)
		testUser2.save(flush:true)
		userUser.save(flush:true)
		
		SecUserSecRole.create testUser, adminRole, true
		SecUserSecRole.create testUser2, adminRole, true
		SecUserSecRole.create userUser, userRole, true
					
    }
    def destroy = {
    }
}
