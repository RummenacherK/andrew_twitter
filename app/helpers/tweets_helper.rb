module TweetsHelper
  def get_tagged(tweet)
      message_arr = Array.new
      message_arr = tweet.message.split
      message_arr.each_with_index do |w, i|
          if w[0] == "#"
              if Tag.pluck(:phrase).include?(w)
                  tag = Tag.find_by(phrase: w)
              else
                  tag = Tag.create(phrase: w)
              end
              tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
              message_arr[i] = "<a href='/tag_tweets?id=#{tag.id}'>#{w}</a>"
          end
      end

      tweet.message = message_arr.join(" ")
      return tweet
  end
end
