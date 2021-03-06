---
date: '2017-02-07 15:19 +0000'
published: true
title: >-
  Scaling Rails through 650 million requests in 5 days: The Donald Trump State
  Visit petition
authors:
  - Andrew White
tags:
  - Rails
main_image: "https://s3-eu-west-1.amazonaws.com/unboxed-web-image-uploader/928e67a6aa8ea487256dd405fc1f1815.PNG"
---

<i>[Parliament Petitions](https://petition.parliament.uk/) is a Rails app which [we built in collaboration with GDS](https://unboxed.co/product-stories/petitions/) during the summer of 2015. Andrew is the lead developer and lead support of the platform, working alongside [Pete Herlihy](https://twitter.com/yahoo_pete) - the Product Owner.</i><br/>

Since last Sunday, our team has been on high alert with Petitions being at the centre of a high-profile political debate. A petition with the aim of preventing President Trump making a State Visit hit the national headlines, gathering a huge number of signatures and a high public following across the week.<br/>

Here’s at look at what happened behind the Petitions system during this time of national debate.<br/>
<br/>

# The situation
It was the morning of Sunday 29th January and Theresa May’s Friday visit to the White House was still riding high in the media headlines. Visiting the Petitions platform, as I do after every major political event, I noticed the traffic beginning to pick up on a single petition which had raised back in November.<br/>

A petition named ‘Prevent Donald Trump from making a State Visit to the United Kingdom’ had been sitting in the system since it was created a couple of months earlier, not gathering a huge amount of much traction. But on this morning, the petition had began flagging as one to watch, with traffic and signatures beginning to increase.<br/>

![Prevent Donald Trump from making a State Visit to the United Kingdom 1](https://s3-eu-west-1.amazonaws.com/unboxed-web-image-uploader/928e67a6aa8ea487256dd405fc1f1815.PNG)
<br/>

This isn’t the first time Donald Trump has triggered a high-profile petition in recent times, so my instinct to the subject matter triggered straight away. Previously holding the highest record of signatures, 2015’s ‘Block Donald J Trump from UK entry’ petition received 586,930 signatures during its six-month lifespan and was one of the greatest early tests of the Petitions system, since launching a few months prior.<br/>
<br/>

# Scaling servers to accommodate signature numbers
With the petition beginning to make its way into the headlines, I watched the system across late Sunday morning as traffic rapidly began picking up more and more. Scaling the number of servers from 4 to 16 ensured everything was working as expected - the system was scaling smoothly. By 2.25 hours, the petition had reached 100,000+ signatures. Following the traffic across the duration of the day, the petition reached an early peak of 75,000 signatures per hour on Sunday. In under 8 hours, it was now sitting at 500,000 signatures.<br/>

The system hadn’t quite seen the peak of this campaign yet. As the media coverage and attention for the petition continued growing across Monday, so were the signature numbers. We then scaled up to accommodate for 85,000 signatures per hour - the petition’s peak so far. With everything perfectly stable, the system was still smoothly running and everything was going to plan.<br/>
<br/>

# Crashing through 1,000,000 signatures
Entering into Monday, this traffic continued growing and excelling. By Monday afternoon, the number of concurrent users had peaked at 50,000, with the system still functioning to accommodate this number of users at one time. In less than 24 hours, the petition had crashed through the 1,000,000-signature barrier - only the second petition to do so.<br/>

From Monday evening, as the media coverage surrounding the campaign and petition began winding down, the traffic in the system slowly began declining. From Tuesday onwards, I could predict that we had seen the peak of this individual petition (although still preparing for this not being the case!). Across Wednesday and Thursday saw a similar trend, with activity gradually slowing down.<br/>
<br/>

# The aftermath
Currently sitting at 1,849,185 signatures (at the time of posting), this is the second biggest petition the system has handled since its launch in 2015.<br/>

![Prevent Donald Trump from making a State Visit to the United Kingdom 2](https://s3-eu-west-1.amazonaws.com/unboxed-web-image-uploader/0ecd2f9e8a7bb99082580594e87413d4.PNG)
<br/>

Sitting behind ‘EU Referendum Rules triggering a 2nd EU Referendum’ with 4,150,260 signatures, I’m not sure this one will be topped - although we are prepared for if that day should ever come!<br/>

Over the busiest five days, the Petitions application processed over 650 million requests, during which it allocated 2.5 trillion objects. 7.8 million background jobs were processed and 4 million emails sent. Finally, the ELB (Elastic Load Balancing) received only 21 errors from the backend - an error rate of just 0.000003% and zero background jobs failed.<br/>
<br/>

# Learning from previous experiences
On the quite rare occasions that a petition sweeps the nation, we have always taken away valuable learning from each individual situation, helping us to improve when faced with the next one.<br/>

One of the issues the system faced with ‘EU Referendum Rules triggering a 2nd EU Referendum’ petition was contention between the same database row and same database column. By re-architecting some of the system following this petition, we were able to create a background job to assume the signature count had gone up, but knowing it will do in a couple of seconds. So instead of 1,500 citizens trying to write in this column every second, we had 20 citizens. This helped smooth out the flow to update and make the database contented, slowing down the pressure on this table and preventing bunching.<br/>

In response to this petition, we also learned to scale to a much higher level. It has proven difficult to test something to this scale without getting a couple of million people to sign a petition. This can’t really be simulated in a test environment so it’s only when a real situation takes place that we can really tell what we’re dealing with.<br/>
<br/>

# Petition Map

![Prevent Donald Trump from making a State Visit to the United Kingdom 3](https://s3-eu-west-1.amazonaws.com/unboxed-web-image-uploader/dedd13e94c9960073dbf9b4090a3d74c.PNG)
<br/>

During this campaign, the number of [Petition Map](http://petitionmap.unboxedconsulting.com/) sessions shot up 7,502.6% from 4,223 sessions on Saturday to 321,060 on Sunday, peaking at 415,010 sessions on Monday:<br/>

![Prevent Donald Trump from making a State Visit to the United Kingdom 4](https://s3-eu-west-1.amazonaws.com/unboxed-web-image-uploader/5c3b4d1198211dfd7f36f5424f6e9326.PNG)

<br/>
Over 953,000 Petition Map sessions took place over the most active five days, with features in online publications such as [Buzzfeed](https://www.buzzfeed.com/jimwaterson/heres-what-that-incredibly-viral-donald-trump-petition-says?utm_term=.ku5GvkBXy#.nag7EkB2Z), [Mail Online](http://www.dailymail.co.uk/news/article-4168906/More-100-000-sign-petition-cancel-Trump-s-UK-visit.html) and Sky News.<br/>

<blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">When I first made Petition Map while working <a href="https://twitter.com/Ubxd">@ubxd</a> I never expected this many people would be using it</p>&mdash; Cale Tilford (@tlfrd) <a href="https://twitter.com/tlfrd/status/826057195913637889">January 30, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<br/>
On a final note, we must say thanks to the thousands of people who have contributed over the years to the open source tools we use like Ruby on Rails, Puma and Delayed Job. You all helped to make a fantastic platform for building stable and scalable web applications. 👍 <br/>

Extra special thanks must go to Matthew Somerville ([@dracos](https://twitter.com/dracos)) who wrote the feature that everyone was talking about on Twitter:<br/>

<blockquote class="twitter-tweet tw-align-center"><p lang="en" dir="ltr">Watching this go up in real time has greatly enhanced the enjoyment of our Sunday roast. <a href="https://t.co/ziv1gammmp">https://t.co/ziv1gammmp</a></p>&mdash; Armando Iannucci (@Aiannucci) <a href="https://twitter.com/Aiannucci/status/825692021797027840">January 29, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<br/>
Even though Matthew isn't part of the official Petitions team he saw the need for a feature that automatically updated the signature count on the page without having to refresh the page. Because we work in the open, Matthew was able to [download the code](https://github.com/alphagov/e-petitions), add the new feature and then [submit a pull request back](https://github.com/alphagov/e-petitions/pull/482) to us. We then merged it and then deployed it back in August last year.
