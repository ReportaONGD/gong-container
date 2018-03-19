#Enable section Informes AECID to Admin user
admin = Usuario.find :first
admin.informes_aecid = true
admin.save!

#Create oauth entry for Gong-Reporte
app = Doorkeeper::Application.create(:name => 'Gong-Reporte', :redirect_uri => "#{ENV["GONGR_URL"]}/ws/authorized")
app.uid= ENV["AD_CLIENT_ID"]
app.secret= ENV["AD_CLIENT_PW"]
app.save!


# Enable plugin Webservice
plugin = Plugin.find_by_codigo("webservice")

if (plugin)
	plugin.activo = 1
else
	plugin = Plugin.create(:nombre => "Webservices Informes AECID",
					:codigo => "webservice",
					:clase => "Webservice", 
					:descripcion => "Modulo de webservices para la obtencion de informes AECID de seguimiento y justificacion final de Proyectos y Convenios",
					:version => "2.50dev",
					:peso => 10,
					:disponible => true,
					:activo => true,
					:engine => true)
end

plugin.save
