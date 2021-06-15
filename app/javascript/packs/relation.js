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

    axios.get(`/users/${userId}/follows/${followId}`)
      .then((response) => {
          const hasFollowed = response.data.hasFollowed
          const followerCount = response.data.followerCounts
          const followingCount = response.data.followingCounts
          $('#follower-count').text(followerCount)
          $('#following-count').text(followingCount)
          followDisplay(hasFollowed)
      })

    $('.follow-btn').on('click', () => {
        axios.post(`/users/${userId}/follows`)
        .then((response) => {
          const followerCount = response.data.followerCounts
          const followingCount = response.data.followingCounts
            if (response.data.status === 'ok') {
                $('.unfollow-btn').removeClass('hidden')
                $('.follow-btn').addClass('hidden')
                $('#follower-count').text(followerCount)
                $('#following-count').text(followingCount)
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
          const followerCount = response.data.followerCounts
          const followingCount = response.data.followingCounts
            if (response.data.status === 'ok') {
                $('.unfollow-btn').addClass('hidden')
                $('.follow-btn').removeClass('hidden')
                $('#follower-count').text(followerCount)
                $('#following-count').text(followingCount)
            }
        })
        .catch((e) => {
            window.alert('Error')
            console.log(e)
        })
    })
})