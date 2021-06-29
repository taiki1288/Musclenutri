module RoomsHelper
    def open_user(room)
        entry = room.entries.where.not(user_id: current_user)
        name = entry[0]&.user
        # userimage = entry[0]&.user&.avatar_image
    end

    def new_message_preview(room)
        message = room.messages.order(updated_at: :desc)
        message = message[0]
        if message.present?
            tag.p "#{message.message}"
        else
            tag.p '[まだメッセージはありません]'
        end
    end
end
