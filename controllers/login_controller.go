package controllers

import (
	"html/template"
	"io/ioutil"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/unrolled/render"
)

func initLoginRouter(router *mux.Router, formatter *render.Render) {
	router.HandleFunc("/login", loginHandler(formatter))
}

func loginHandler(formatter *render.Render) http.HandlerFunc {

	return func(w http.ResponseWriter, req *http.Request) {
		html, _ := ioutil.ReadFile("./views/login.html")
		page := layout{
			Title:   "登录 - 图蜂后台管理系统",
			Content: template.HTML(string(html)),
		}
		formatter.HTML(w, http.StatusOK, "layout", page)
	}

}