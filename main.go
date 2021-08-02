package main

import (
	"cockroach-gorm/models"
	"github.com/google/uuid"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"log"
	"os"
	"time"
)

func main() {

	dsn := os.Getenv("PG_DSN")
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})
	if err != nil {
		log.Println(err)
		panic(err)
	}
	t := time.Now()
	transaction := models.Transaction{
		ID:              uuid.New().String(),
		ParentAccountID: "invalid-acct-id",
		CreatedAt:       t.Unix(),
	}

	dbResult := db.Create(&transaction)
	if dbResult.Error != nil {
		log.Println("DBError: ", dbResult.Error)
	}

}
