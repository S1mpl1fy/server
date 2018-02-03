package models

import (
	"time"

	"github.com/sunyatsuntobee/server/logger"
)

// ActivityStage Model
type ActivityStage struct {
	ID         int       `xorm:"id INT PK NOTNULL UNIQUE AUTOINCR" json:"id"`
	StageNum   int       `xorm:"stage_num INT NOTNULL" json:"stage_num"`
	StartTime  time.Time `xorm:"start_time DATETIME NOTNULL" json:"start_time"`
	EndTime    time.Time `xorm:"end_time DATETIME NOTNULL" json:"end_time"`
	Location   string    `xorm:"location VARCHAR(45) NOTNULL" json:"location"`
	Content    string    `xorm:"content VARCHAR(200) NOTNULL" json:"content"`
	ActivityID int       `xorm:"activity_id INT NOTNULL INDEX(activity_id_idx)"
	json:"activity_id"`
}

type ActivityStageDataAccessObject struct{}

var ActivityStageDAO *ActivityStageDataAccessObject

func (*ActivityStageDataAccessObject) TableName() string {
	return "activity_stages"
}

func (*ActivityStageDataAccessObject) FindByAID(aid int) []ActivityStage {
	l := make([]ActivityStage, 0)
	err := orm.Table(ActivityStageDAO.TableName()).Where("activity_id=?", aid).
		Find(&l)
	logger.LogIfError(err)
	return l
}
