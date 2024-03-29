package doctor



import grails.test.mixin.*
import spock.lang.*
import grails.plugin.springsecurity.SpringSecurityService


@TestFor(SubServicioController)
@Mock([SubServicio, SpringSecurityService])
class SubServicioControllerSpec extends Specification {
	
	def setupSpec() {
		SpringSecurityService.metaClass.principal = { id -> 1 }
	}

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["nombre"] = 'someValidName'
		params["descripcion"] = 'someValiddescripcion'
		params["colorHexadecimal"] = 'someValiddescripcion'	
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.subServicioList
            model.subServicioCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.subServicio!= null
    }

    void "Test the save action correctly persists an instance"() {
        
		when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
			def springSecurityService = mockFor(SpringSecurityService,true)
			
            def subServicio = new SubServicio()
			
            subServicio.validate()
            controller.save(subServicio)

        then:"The create view is rendered again with the correct model"
            model.subServicio!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            subServicio = new SubServicio(params)
			
            controller.save(subServicio)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/subServicio/show/1'
            controller.flash.message != null
            SubServicio.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def subServicio = new SubServicio(params)
            controller.show(subServicio)

        then:"A model is populated containing the domain instance"
            model.subServicio == subServicio
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def subServicio = new SubServicio(params)
            controller.edit(subServicio)

        then:"A model is populated containing the domain instance"
            model.subServicio == subServicio
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/subServicio/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def subServicio = new SubServicio()
            subServicio.validate()
            controller.update(subServicio)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.subServicio == subServicio

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            subServicio = new SubServicio(params).save(flush: true)
            controller.update(subServicio)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/subServicio/show/$subServicio.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/subServicio/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def subServicio = new SubServicio(params).save(flush: true)

        then:"It exists"
            SubServicio.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(subServicio)

        then:"The instance is deleted"
            SubServicio.count() == 0
            response.redirectedUrl == '/subServicio/index'
            flash.message != null
    }
}
