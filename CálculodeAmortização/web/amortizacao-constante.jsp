<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Locale" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Amortização Constante</title>
    <%@include file="WEB-INF/jspf/vendor.jspf" %>
    <style>
        #main {
            padding: 1em;
        }

        #divisor {
            width: 80%;
            color: black;
            height: 2px;
            background-color: black;
        }
    </style>
</head>
<body>
<%@include file="WEB-INF/jspf/header.jspf" %>

    <div id="main" class="container-fluid">
        <form method="post" action="#">
            <table class="table table-info table-bordered m-auto">
                <tr>
                    <td colspan="2"><h1 class="text text-center m-3">Amortização Constante</h1></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p>É conhecido como Tabela SAC, onde as parcelas tem valores <b>decrescentes</b></p>

                        <p>Fórmula aplicada:</p>
                        <ul>
                            <li>Parcela = amortização + jurosSobreSaldoDevedor</li>
                        </ul>
                    </td>
                </tr>
                <tr class="text text-center">
                    <td class="text text-left"><label for="valor">Valor Financiado</label></td>
                    <td><input id="valor" name="valor" type="text" size="50px"/></td>
                </tr>
                <tr class="text text-center">
                    <td class="text text-left"><label for="meses">Meses</label></td>
                    <td><input id="meses" name="meses" class="text text-right" type="text" size="50px"/></td>
                </tr>
                <tr class="text text-center">
                    <td class="text text-left"><label for="taxa">Taxa Mensal</label></td>
                    <td><input id="taxa" name="taxa" type="text" size="50px"/></td>
                </tr>
                <tr class="text text-center">
                    <td colspan="2">
                        <input id="limpar" type="reset" name="limpar" value="Limpar" class="btn btn-danger m-3"/>
                        <input type="submit" name="calcular" value="Calcular" class="btn btn-primary"/>
                    </td>
                </tr>
            </table>
        </form>

        <% if (request.getParameter("calcular") != null) {
            try {
                double valor = Double.parseDouble(request.getParameter("valor"));
                int meses = Integer.parseInt(request.getParameter("meses"));
                double taxa = Double.parseDouble(request.getParameter("taxa"));
                double amortizacao = valor / meses;
                double parcela;
                double acumulado = 0;
                double saldoDevedor = valor;
                double juros;
                double jurosAcumulados = 0;
                taxa /= 100;

                Locale.setDefault(new Locale("pt", "BR"));
                DecimalFormat monetario = new DecimalFormat("R$ #,##0.00");
                DecimalFormat porcentagem = new DecimalFormat("#0.00");
        %>

            <hr id="divisor"/>

            <table id="tabela" class="table table-dark table-bordered table-hover text-center">
                <tr>
                    <td colspan="5">
                        <h1>Resultado</h1>
                        <p><b>Valor:</b> <%= monetario.format(valor)%></p>
                        <p><b>Meses:</b> <%= meses%></p>
                        <p><b>Taxa:</b> <%= porcentagem.format(taxa * 100)%> %</p>
                    </td>
                </tr>
                <tr>
                    <th>Parcela</th>
                    <th>Valor</th>
                    <th>Amortização</th>
                    <th>Juros</th>
                    <th>Saldo Devedor</th>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><%=monetario.format(saldoDevedor)%></td>
                </tr>

                <% for (int mes = 0; mes < meses; mes++) {
                    juros = taxa * (valor - (mes * amortizacao));
                    parcela = amortizacao + juros;
                    acumulado += parcela;
                    jurosAcumulados += juros;
                    saldoDevedor -= amortizacao;%>

                    <tr>
                        <td><%=mes + 1%>º</td>
                        <td><%=monetario.format(parcela)%>
                        </td>
                        <td><%=monetario.format(amortizacao)%>
                        </td>
                        <td><%=monetario.format(juros)%>
                        </td>
                        <td><%=monetario.format(saldoDevedor)%>
                        </td>
                    </tr>

            <%}%>
            <tr>
                <td>Total</td>
                <td><%=monetario.format(acumulado)%>
                </td>
                <td><%=monetario.format(amortizacao * meses)%>
                </td>
                <td><%=monetario.format(jurosAcumulados)%>
                </td>
                <td></td>
            </tr>
        </table>
        <%} catch (Exception e) { %>
            <h2 id="erro" class="text text-danger text-center m-5">Dados inválidos</h2>
        <%}%>

    <%}%>
    </div>

    <%@include file="WEB-INF/jspf/footer.jspf" %>

    <script>
        $(document).ready(function () {
            $("#limpar").click(function () {
                $("#erro").remove();
                $("#tabela").remove();
                $("#divisor").remove();
            });

            $("#valor").inputmask("currency", {
                positionCaretOnClick: "ignore",
                radixPoint: ",",
                removeMaskOnSubmit: true,
                _radixDance: false,
                numericInput: true,
                unmaskAsNumber: true,
                prefix: "R$"
            });

            $("#meses").inputmask("integer", {
                numericInput: true,
                unmaskAsNumber: true,
                min: 1
            });

            $("#taxa").inputmask("decimal", {
                positionCaretOnClick: "ignore",
                radixPoint: ",",
                removeMaskOnSubmit: true,
                _radixDance: false,
                numericInput: true,
                unmaskAsNumber: true,
                suffix: " %"
            });
        });
    </script>
</body>
</html>
