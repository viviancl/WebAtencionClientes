using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAtencionClientes.Models.ViewModels
{
    public class ColaViewModel
    {
        public int IdTipoCola { get; set; }
        public string IdentificacionCliente { get; set; }
        public string Nombre { get; set; }
        public string Estado { get; set; }
    }
}