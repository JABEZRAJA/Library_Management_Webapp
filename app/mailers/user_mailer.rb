class UserMailer < ApplicationMailer
  def login_success_email(user)
    @user = user
    mail(to: @user.email, subject: 'Login Successful')
  end

  def rent_mailer_alert
    @user = params[:user]
    @book = params[:book]
    attachments['receipt.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'MyPDF', template: 'borrowed_books/borrowed_books_pdf.html')
    )
    mail(to: @user.email, subject: 'User Book Rent Alert') do |format|
      format.html { render layout: 'mailer.html' }
    end
  end

  def unrent_mailer_alert
    @user = params[:user]
    @book = params[:book]
    attachments['receipt.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'MyPDF', template: 'borrowed_books/returned_books_pdf.html')
    )
    mail(to: @user.email, subject: 'User Book UnRent Alert')
  end
end
