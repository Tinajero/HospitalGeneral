package doctor



import grails.test.mixin.*
import spock.lang.*

@TestFor(ServicioController)
@Mock(Servicio)
class ServicioControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.servicioList
            model.servicioCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.servicio!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def servicio = new Servicio()
            servicio.validate()
            controller.save(servicio)

        then:"The create view is rendered again with the correct model"
            model.servicio!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            servicio = new Servicio(params)

            controller.save(servicio)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/servicio/show/1'
            controller.flash.message != null
            Servicio.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def servicio = new Servicio(params)
            controller.show(servicio)

        then:"A model is populated containing the domain instance"
            model.servicio == servicio
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def servicio = new Servicio(params)
            controller.edit(servicio)

        then:"A model is populated containing the domain instance"
            model.servicio == servicio
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/servicio/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def servicio = new Servicio()
            servicio.validate()
            controller.update(servicio)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.servicio == servicio

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            servicio = new Servicio(params).save(flush: true)
            controller.update(servicio)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/servicio/show/$servicio.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/servicio/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def servicio = new Servicio(params).save(flush: true)

        then:"It exists"
            Servicio.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(servicio)

        then:"The instance is deleted"
            Servicio.count() == 0
            response.redirectedUrl == '/servicio/index'
            flash.message != null
    }
}
