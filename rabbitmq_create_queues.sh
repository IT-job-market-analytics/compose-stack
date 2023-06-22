function create_queue {
    curl --request PUT \
    --url "http://localhost:15672/api/queues/%2F/$1" \
    --header 'Authorization: Basic YW5hbHl0aWNzX3NlcnZpY2U6cGFzc3dvcmQ=' \
    --data-raw '{
        "auto_delete": false,
        "durable": true,
        "arguments": {}
    }'
}

function create_direct_exchange {
    curl --request PUT \
    --url "http://localhost:15672/api/exchanges/%2F/$1" \
    --header 'Authorization: Basic YW5hbHl0aWNzX3NlcnZpY2U6cGFzc3dvcmQ=' \
    --data-raw '{
        "type": "direct",
        "auto_delete": false,
        "durable": true,
        "arguments": {}
    }'
}

function create_binding {
    curl --request POST \
    --url "http://localhost:15672/api/bindings/%2F/e/scheduled-tasks-exchange/q/$1" \
    --header 'Authorization: Basic YW5hbHl0aWNzX3NlcnZpY2U6cGFzc3dvcmQ=' \
    --data-raw '{
        "routing_key": "",
        "arguments": {}
    }'
}

create_queue scheduled-tasks-queue
create_queue imported-vacancies-queue
create_queue new-vacancies-queue
create_queue telegram-notifications-queue

create_direct_exchange scheduled-tasks-exchange

create_queue vacancy-import-scheduled-tasks-queue
create_queue analytics-builder-scheduled-tasks-queue

create_binding vacancy-import-scheduled-tasks-queue
create_binding analytics-builder-scheduled-tasks-queue