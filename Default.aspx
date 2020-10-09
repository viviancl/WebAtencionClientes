<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebAtencionClientes._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <div class="form-group">
            <div class="row" style="text-align: center">
                <div class="col-sm-12">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="lblReloj" runat="server" Text="Label" Font-Names="Book Antiqua" Font-Size="XX-Large" ForeColor="#2196f3 "></asp:Label>
                            <asp:Timer ID="tmrRelojInterno" runat="server" OnTick="TmrRelojInterno_Tick" Interval="1000"></asp:Timer>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <div>
            <asp:Timer ID="tmrActualizarEstado" OnTick="TmrActualizarEstado_Tick" runat="server" Interval="20000">
            </asp:Timer>
        </div>
        <hr />
        <div class="form-group">
            <div class="row" style="display: flex; align-items: center">
                <div class="col-sm-4">
                    <span><strong>Identificación</strong></span>
                    <asp:TextBox ID="txbIdentificacion" class="form-control" runat="server" MaxLength="13" ValidationGroup="Registrar"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revIdentificacion"
                        runat="server" ErrorMessage="Debe ingresar sólo números."
                        ControlToValidate="txbIdentificacion" ValidationExpression="\d+"
                        ValidationGroup="Registrar" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator runat="server" ID="rfvIdentificacion" ControlToValidate="txbIdentificacion"
                        ErrorMessage="Campo requerido" ValidationGroup="Registrar" Display="Dynamic" ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-4">
                    <span><strong>Nombre del Cliente</strong></span>
                    <asp:TextBox ID="txbNombre" class="form-control" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revNombre"
                        runat="server" ErrorMessage="Debe ingresar sólo letras."
                        ControlToValidate="txbNombre" ValidationExpression="[a-zA-Z ]{1,254}"
                        ValidationGroup="Registrar" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator runat="server" ID="rfvNombre" ControlToValidate="txbNombre"
                        ErrorMessage="Campo requerido" ValidationGroup="Registrar" Display="Dynamic" ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-4">
                    <asp:Button ID="btnRegistrar" CssClass="btn btn-info" runat="server" Text="Registrar" OnClick="BtnRegistrar_Click" ValidationGroup="Registrar" />
                </div>
            </div>
        </div>
        <asp:Label ID="lblMensaje" runat="server" Text="El cliente ingresado se encuentra en proceso de atención" Visible="false" ForeColor="Red"></asp:Label>
        <hr />
        <div class="row">
            <div class="col-md-3">
                <h3>Cola 1</h3>
                <asp:GridView ID="GridViewCola1" runat="server" AutoGenerateColumns="false" Width="80%">
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#2196f3" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <Columns>
                        <asp:BoundField DataField="IdTipoCola" HeaderText="Cola" Visible="false" />
                        <asp:BoundField DataField="IdentificacionCliente" HeaderText="Id" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="col-md-3">
                <h3>Cola 2</h3>
                <asp:GridView ID="GridViewCola2" runat="server" AutoGenerateColumns="false" Width="80%">
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#2196f3" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <Columns>
                        <asp:BoundField DataField="IdTipoCola" HeaderText="Cola" Visible="false" />
                        <asp:BoundField DataField="IdentificacionCliente" HeaderText="Id" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="col-md-6">
                <h3>Histórico de Atenciones</h3>
                <asp:GridView ID="GridViewHistoricoAtenciones" runat="server" AutoGenerateColumns="false" Width="100%"
                    AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#2196f3" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <Columns>
                        <asp:BoundField DataField="IdCola" HeaderText="Cola" Visible="false" />
                        <asp:BoundField DataField="IdentificacionCliente" HeaderText="Id" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="FechaHoraAtencion" HeaderText="Hora Atención" />
                        <asp:BoundField DataField="FechaHoraSalida" HeaderText="Hora Salida" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>