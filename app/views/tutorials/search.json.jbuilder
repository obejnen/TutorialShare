json.tutorials do
    json.array!(@tutorials) do |tutorial|
        json.title tutorial.title
        json.url tutorial_path(tutorial)
    end
end