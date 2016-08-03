for i <- 1..100 do
  %Returb.Kitten{name: "Kitten number: #{i}"}
  |> Returb.Repo.insert!()
end

for i <- 1..100 do
  %Returb.Post{title: "Post: #{i}", body: "Some post content: #{i}"}
  |> Returb.Repo.insert!()
end
