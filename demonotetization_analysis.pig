raw_data = load '/user/cloudera/bda_project/dataset/demonetization-tweets.csv' using PigStorage(',');

get_details = foreach raw_data generate $0 as id,$1 as text;

tokens = foreach get_details generate id,text,FLATTEN(TOKENIZE(text)) as words;

dictionary = load '/user/cloudera/bda_project/dictionary/weights.txt' using PigStorage('\t') as (word:chararray,rating:int);

word_ratings = join tokens by words left outer, dictionary by word using 'replicated';

ratings = foreach word_ratings generate tokens::id as id,tokens::text as text,dictionary::rating as rating; 

group_words = group ratings by (id,text);

avg_ratings = foreach group_words generate group,AVG(ratings.rating) as tweet_rating;

positive_tweets = filter avg_ratings by tweet_rating > 0;
neutral_tweets = filter avg_ratings by tweet_rating == 0;
negative_tweets = filter avg_ratings by tweet_rating < 0;

positive_group = Group positive_tweets all;
neutral_group = Group neutral_tweets all;
negative_group = Group negative_tweets all;

positive_count = foreach positive_group generate COUNT(positive_tweets);
neutral_count = foreach neutral_group generate COUNT(neutral_tweets);
negative_count = foreach negative_group generate COUNT(negative_tweets);

store ratings INTO '/user/cloudera/bda_project/results/grouped_ratings' using PigStorage('|');

store word_ratings INTO '/user/cloudera/bda_project/results/word_ratings' using PigStorage('|');

store positive_tweets INTO '/user/cloudera/bda_project/results/positive_tweets' using PigStorage(',');

store neutral_tweets INTO '/user/cloudera/bda_project/results/neutral_tweets' using PigStorage(',');

store negative_tweets INTO '/user/cloudera/bda_project/results/negative_tweets' using PigStorage(',');

store positive_count INTO '/user/cloudera/bda_project/results/positive_count' using PigStorage(' ');

store neutral_count INTO '/user/cloudera/bda_project/results/neutral_count' using PigStorage(' ');

store negative_count INTO '/user/cloudera/bda_project/results/negative_count' using PigStorage(' ');


