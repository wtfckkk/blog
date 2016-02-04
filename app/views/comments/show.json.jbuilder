json.extract! @comment, :id, :user_id, :article_id, :cuerpo, :created_at, :updated_at
json.user do
	json.email @comment.user.email
end
