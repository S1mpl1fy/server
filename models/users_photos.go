package models

// UserPhotoRelationship Model
type UsersPhotos struct {
	ID           int `xorm:"id INT PK NOTNULL UNIQUE AUTOINCR"`
	UserID       int `xorm:"user_id INT NOTNULL INDEX(user_id_idx)"`
	LikedPhotoID int `xorm:"liked_photo_id INT NOTNULL INDEX(liked_photo_id_idx)"`
}

func NewUsersPhotos(user_id int, liked_photo_id int) *UsersPhotos {
	return &UsersPhotos{
		UserID:       user_id,
		LikedPhotoID: liked_photo_id,
	}
}