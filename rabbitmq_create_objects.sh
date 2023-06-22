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

create_queue scheduled-tasks-queue
create_queue imported-vacancies-queue
create_queue new-vacancies-queue
create_queue telegram-notifications-queue