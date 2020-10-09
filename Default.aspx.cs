using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using WebAtencionClientes.Controllers;

namespace WebAtencionClientes
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                UpdateTimer();

                ColaController.ActualizarEstados();

                MostrarColas();
            }
        }

        protected void MostrarColas()
        {
            GridViewCola1.DataSource = ColaController.ListarColas().Where(t => t.IdTipoCola == 1);
            GridViewCola1.DataBind();

            GridViewCola2.DataSource = ColaController.ListarColas().Where(t => t.IdTipoCola == 2);
            GridViewCola2.DataBind();

            GridViewHistoricoAtenciones.DataSource = ColaController.ListarHistoricoRegistros();
            GridViewHistoricoAtenciones.DataBind();
        }
        protected void LimpiarControles()
        {
            txbIdentificacion.Text = string.Empty;
            txbNombre.Text = string.Empty;
        }

        protected void BtnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                lblMensaje.Visible = false;

                string identificacion = txbIdentificacion.Text;

                string nombre = txbNombre.Text;

                if (!ClienteController.ConsultarIdentificacion(identificacion))
                {
                    ClienteController.RegistrarCliente(identificacion, nombre);

                    ColaController.ActualizarEstados();

                    MostrarColas();
                }
                else { lblMensaje.Visible = true; }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error");
            }
            finally
            {
                LimpiarControles();
            }
        }
        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewHistoricoAtenciones.PageIndex = e.NewPageIndex;
            MostrarColas();
        }
        private void UpdateTimer()
        {
            lblReloj.Text = DateTime.Now.ToLongTimeString();
        }
        protected void TmrRelojInterno_Tick(object sender, EventArgs e)
        {
            UpdateTimer();
        }
        protected void TmrActualizarEstado_Tick(object sender, EventArgs e)
        {
            ColaController.ActualizarEstados();
            MostrarColas();
        }
    }
}