# frozen_string_literal: true
module BatchNotifier
  class Transactional
    ENDPOINT = "transactional/send"

    def initialize(group_id, recipients, title, body)
      @group_id   = group_id
      @recipients = recipients
      @title      = title
      @body       = body
    end

    def payload
      payload = {}
      payload.merge!(**group_id, **recipients, **message)
    end

    def group_id
      { group_id: @group_id }
    end

    def recipients
      { recipients: @recipients }
    end

    def message
      { message: { title: @title, body: @body } }
    end
  end
end
