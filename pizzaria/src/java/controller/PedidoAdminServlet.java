package controller;
import dao.PedidoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/pedido")
public class PedidoAdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("admin") == null) { resp.sendRedirect(req.getContextPath()+"/login.jsp"); return; }
        String acao = req.getParameter("acao");
        PedidoDAO dao = new PedidoDAO();
        if ("ver".equals(acao)) {
            req.setAttribute("pedido", dao.buscarPorId(Integer.parseInt(req.getParameter("id"))));
            req.getRequestDispatcher("/admin/verPedido.jsp").forward(req, resp);
        } else if ("status".equals(acao)) {
            dao.atualizarStatus(Integer.parseInt(req.getParameter("id")), req.getParameter("status"));
            resp.sendRedirect("pedido");
        } else if ("excluir".equals(acao)) {
            dao.excluir(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect("pedido");
        } else {
            req.setAttribute("pedidos", dao.listarTodos());
            req.getRequestDispatcher("/admin/pedidos.jsp").forward(req, resp);
        }
    }
}
