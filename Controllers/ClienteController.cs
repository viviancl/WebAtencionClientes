using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebAtencionClientes.Models;

namespace WebAtencionClientes.Controllers
{
    public class ClienteController
    {
        public static bool ConsultarIdentificacion(string identificacion)
        {
            using (AtencionClientesEntities db = new AtencionClientesEntities())
            {
                var query = (from cl in db.Clientes
                             join c in db.Colas on cl.IdCliente equals c.IdCliente
                             where cl.Identificacion == identificacion
                             where c.IdEstado != 3
                             select cl).Count();
                if (query == 0)
                    return false;
                else
                    return true;
            }
        }

        public static void RegistrarCliente(string identificacion, string nombre)
        {
            using (AtencionClientesEntities db = new AtencionClientesEntities())
            {
                try
                {
                    Cliente cliente = new Cliente
                    {
                        Identificacion = identificacion,
                        Nombre = nombre
                    };

                    int idCliente = cliente.IdCliente;

                    DeterminarColaMenorEspera_Result result = db.DeterminarColaMenorEspera().FirstOrDefault();

                    int idTipoCola = result.TipoCola;
                    DateTime horaUltimaAtencion = result.FechaHoraSalida;

                    int duracion = (from t in db.TipoColas
                                    where t.IdTipoCola == idTipoCola
                                    select t).FirstOrDefault().Duracion;

                    DateTime horaEntrada = DateTime.Now;

                    DateTime horaAtencion = horaEntrada;
                    if (horaUltimaAtencion > horaEntrada)
                        horaAtencion = horaUltimaAtencion;

                    DateTime horaSalida = horaAtencion.AddMinutes(duracion);

                    Cola cola = new Cola
                    {
                        IdTipoCola = idTipoCola,
                        IdCliente = idCliente,
                        HoraEntrada = horaEntrada,
                        FechaHoraAtencion = horaAtencion,
                        FechaHoraSalida = horaSalida,
                        IdEstado = 1 //Por defecto se agrega el cliente En espera
                    };

                    db.Clientes.Add(cliente);
                    db.Colas.Add(cola);
                    db.SaveChanges();
                }
                catch (Exception e)
                {
                    throw e;
                }

            }
        }
    }
}