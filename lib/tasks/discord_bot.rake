namespace :discord_bot do
  desc "Run Discord bot"
  task run: :environment do
    bot = Discordrb::Bot.new token: ENV["DISCORD_BOT_TOKEN"]

    bot.message(contains: /.*/) do |event|
      event.message.attachments.each do |attachment|
        if attachment.image?
          image_url = attachment.url

          response = Faraday.get(image_url)

          discord_uid = event.author.id
          user = User.where(provider: "discord", uid: discord_uid).first_or_create(
            email: discord_uid.to_s + "@tyriens.fr",
            password: Devise.friendly_token[0, 20],
            username: event.author.username
          )

          image = user.images.new
          image.source_url = image_url
          image.file.attach(
            io: StringIO.new(response.body),
            filename: image_url,
            content_type: response.headers["Content-Type"],
          )

          if image.save
            event.respond "J'ai enregistré ton image !"
          else
            event.respond "Une erreur s'est produite lors de l'enregistrement de ton image."
          end
        end
      end
    end

    bot.run
  end
end
