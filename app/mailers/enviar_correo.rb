class EnviarCorreo < ActionMailer::Base
  default from: "correo.winner@gmail.com"

  def correo_notificacion(user)
  	@user=user
  	#envio de correo
  	mail(to: @user, subject: "Nueva competencia")
  end


end