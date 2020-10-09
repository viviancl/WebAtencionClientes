using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAtencionClientes.Models.ViewModels
{
    public class HistoricoAtencionesViewModel
    {
        public int IdCola { get; set; }
        public string IdentificacionCliente { get; set; }
        public string Nombre { get; set; }
        public DateTime FechaHoraAtencion { get; set; }
        public DateTime FechaHoraSalida { get; set; }
    }
}