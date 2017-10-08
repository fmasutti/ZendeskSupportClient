# ZendeskSupportClient
Simple Zendesk Support client project.

This is a sample App using MVC pattern to show how get “tickets” from Zendesk API.

There is no login process, because we are using some mocked infos just demonstrate an asynchronous request from ZendeskAPI to get “Tickets”.

To do it, I used two different Pods:

Alamofire to help with the networking layer.

ICSPullToRefresh to help with a paged TableView to show the tickets with a “Infinite Scroll”

Remember when you download the project, you should run ‘Pod update’.


I implemented as well some Unit tests.