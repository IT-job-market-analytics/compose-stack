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
    --url "http://localhost:15672/api/bindings/%2F/e/$2/q/$1" \
    --header 'Authorization: Basic YW5hbHl0aWNzX3NlcnZpY2U6cGFzc3dvcmQ=' \
   --data-raw "{
          \"routing_key\": \"$3\",
          \"arguments\": {}
      }"
}

# scheduler
create_queue scheduled-tasks-queue
create_direct_exchange scheduled-tasks-exchange

## consumers of messages produces by scheduler

### tasks to vacancy-import-service
create_queue vacancy-import-scheduled-tasks-queue
create_binding vacancy-import-scheduled-tasks-queue scheduled-tasks-exchange vacancy-import-service-task

### tasks to analytics-builder-service
create_queue analytics-builder-scheduled-tasks-queue
create_binding analytics-builder-scheduled-tasks-queue scheduled-tasks-exchange analytics-builder-service-task

# vacancy-import-service
create_queue imported-vacancies-queue

# vacancy-storage-service
create_queue new-vacancies-queue

# vacancy-notifier-service
create_queue telegram-notifications-queue