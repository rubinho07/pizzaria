package controller;
import dao.*;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario admin = (Usuario) req.getSession().getAttribute("admin");
        if (admin == null) { resp.sendRedirect(req.getContextPath()+"/login.jsp"); return; }
        req.setAttribute("totalPizzas", new PizzaDAO().listarTodos().size());
        req.setAttribute("totalPedidos", new PedidoDAO().listarTodos().size());
        req.setAttribute("ultimosPedidos", new PedidoDAO().listarTodos().stream().limit(5).toList());
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}
