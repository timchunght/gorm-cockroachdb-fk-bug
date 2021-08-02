package models

type Transaction struct {
	ID               string  `gorm:"column:id" json:"id" validate:"required"`
	ParentAccountID  string  `gorm:"column:parent_account_id" json:"parent_account_id"`
	PaymentChannelID *string `gorm:"column:payment_channel_id" json:"payment_channel_id"`
	CreatedAt        int64   `gorm:"column:created_at" json:"created_at"`
	UpdatedAt        int64   `gorm:"column:updated_at" json:"updated_at"`
}
