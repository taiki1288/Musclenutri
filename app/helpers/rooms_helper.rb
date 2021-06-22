module RoomsHelper
    def open_user(room)
        entry = room.entries.where.not(user_id: current_user)
        # binding.pry
        entry[0].user.username
    end

    def new_message_preview(room)
        message = room.messages.order(updated_at: :desc)
        message = message[0]
    end
end