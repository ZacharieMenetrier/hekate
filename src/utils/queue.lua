-- From the book "Programming in lua"

queue = {}

function queue.new ()
  return {first = 0, last = -1}
end

function queue.push_action_last (queue, value)
  local last = queue.last + 1
  queue.last = last
  queue[last] = value
end

-- Return False if the queue is empty, otherwise pops and returns the element
function queue.pop_first_action (queue)
  local first = queue.first
  if first > queue.last then
    --print("queue is empty")
    return False
    end
  local value = queue[first]
  queue[first] = nil        -- to allow garbage collection
  queue.first = first + 1
  return value
end

return queue
