package dao;
import model.Usuario;
import util.Conexao;
import java.sql.*;

public class UsuarioDAO {
    public Usuario autenticar(String email, String senha) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM usuario WHERE email=? AND senha=?")) {
            st.setString(1,email); st.setString(2,senha);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id")); u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email")); u.setSenha(rs.getString("senha"));
                u.setPerfil(rs.getString("perfil")); return u;
            }
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
        return null;
    }
}
