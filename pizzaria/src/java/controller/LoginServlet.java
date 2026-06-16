package controller;
import dao.UsuarioDAO;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");
        Usuario u = new UsuarioDAO().autenticar(email, senha);
        if (u != null) {
            req.getSession().setAttribute("admin", u);
            resp.sendRedirect("admin/dashboard");
        } else {
            req.setAttribute("erro", "Email ou senha incorretos.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
