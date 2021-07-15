using System;
using System.ComponentModel.DataAnnotations;

namespace Quotation.Common
{
    public class GenericResponse<T> where T : class
    {
        [Display(Name = "statuscode")]
        public string StatusCode { get; protected set; }
        [Display(Name = "status")]
        public bool Status { get; protected set; }
        [Display(Name = "message")]
        public string Message { get; protected set; }
        [Display(Name = "result")]
        public T Result { get; protected set; }

        public GenericResponse(string statusCode, bool status, string message, T result)
        {
            Status = status;
            StatusCode = statusCode;
            Message = message;
            Result = result;
        }
    }
}
