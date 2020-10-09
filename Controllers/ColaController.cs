using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAtencionClientes.Models;
using WebAtencionClientes.Models.ViewModels;

namespace WebAtencionClientes.Controllers
{
    public class ColaController
    {
        public static List<ColaViewModel> ListarColas()
        {
            using (AtencionClientesEntities db = new AtencionClientesEntities())
            {

                var query = from c in db.Colas
                            join cl in db.Clientes on c.IdCliente equals cl.IdCliente
                            join e in db.Estadoes on c.IdEstado equals e.IdEstado
                            where c.IdEstado != 3
                            select new ColaViewModel
                            {
                                IdTipoCola = c.IdTipoCola,
                                IdentificacionCliente = cl.Identificacion,
                                Nombre = cl.Nombre,
                                Estado = e.Estado1
                            };
                return query.ToList();
            }
        }

        public static List<HistoricoAtencionesViewModel> ListarHistoricoRegistros()
        {
            using (AtencionClientesEntities db = new AtencionClientesEntities())
            {

                var query = from c in db.Colas
                            join cl in db.Clientes on c.IdCliente equals cl.IdCliente
                            where c.IdEstado == 3
                            orderby c.FechaHoraAtencion descending
                            select new HistoricoAtencionesViewModel
                            {
                                IdCola = c.IdCola,
                                IdentificacionCliente = cl.Identificacion,
                                Nombre = cl.Nombre,
                                FechaHoraAtencion = c.FechaHoraAtencion,
                                FechaHoraSalida = c.FechaHoraSalida
                            };
                return query.ToList();
            }
        }

        public static void ActualizarEstados()
        {
            using (AtencionClientesEntities db = new AtencionClientesEntities())
            {
                try
                {
                    DateTime fechaHoraMomento = DateTime.Now;

                    db.ActualizarEstadosAtencion(fechaHoraMomento);
                }
                catch (Exception e)
                {
                    throw e;
                }
            }
        }
    }
}