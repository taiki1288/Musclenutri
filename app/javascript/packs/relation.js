import $ from 'jquery'
import axios from 'axios'
// import { csrfToken } from 'rails-ujs'
// axios.defaults.headers.common[ 'X-CSRF-Token' ] = csrfToken()


const followDisplay = (hasFollowed) => {
    if (hasFollowed) {
        $('.unfollow-btn').removeClass('hidden')
    } else {
        $('.follow-btn').removeClass('hidden')
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#user-show').data();
    const userId = dataset.userId
    const followId = dataset.followingId

    axios.get(`/users/${userId}`)
      .then((response) => {
        // debugger
          const hasFollowed = response.data.hasFollowed
          followDisplay(hasFollowed)
      })

    $('.follow-btn').on('click', () => {
        axios.post(`/users/${userId}/follows`)
        .then((response) => {
            if (response.data.status === 'ok') {
                $('.unfollow-btn').removeClass('hidden')
                $('.follow-btn').addClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })

    $('.unfollow-btn').on('click', () => {
        axios.post(`/users/${userId}/unfollows`)
        .then((response) => {
            if (response.data.status === 'ok') {
                $('.unfollow-btn').addClass('hidden')
                $('.follow-btn').removeClass('hidden')
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })
})