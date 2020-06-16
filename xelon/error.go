package xelon

import (
	"errors"
	"fmt"
	"net/http"
)

var (
	ErrEmptyArgument          = errors.New("(api) argument cannot be empty")
	ErrEmptyPayloadNotAllowed = errors.New("(api) empty payload not allowed")
)

type ErrorResponse struct {
	Response     *http.Response
	ErrorElement ErrorElement
}

type ErrorElement struct {
	Error string `json:"error,omitempty"`
	Code  int    `json:"code,omitempty"`
}

func (r *ErrorResponse) Error() string {
	return fmt.Sprintf("%v %v: %d %+v",
		r.Response.Request.Method, sanitizeURL(r.Response.Request.URL), r.Response.StatusCode, r.ErrorElement)
}
