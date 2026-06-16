package dao;
import model.Adicional;
import util.Conexao;
import java.sql.*;
import java.util.*;

public class AdicionalDAO {

    public List<Adicional> listarTodos() {
        List<Adicional> lista = new ArrayList<>();
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM adicional WHERE disponivel=true ORDER BY tipo, nome"); ResultSet rs = st.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (Exception e) { throw new RuntimeException("Erro ao listar adicionais: "+e.getMessage(),e); }
        return lista;
    }

    public void inserir(Adicional a) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("INSERT INTO adicional (nome,descricao,preco,tipo,disponivel) VALUES (?,?,?,?,?)")) {
            st.setString(1,a.getNome()); st.setString(2,a.getDescricao());
            st.setBigDecimal(3,a.getPreco()); st.setString(4,a.getTipo()); st.setBoolean(5,a.isDisponivel());
            st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
    }

    public void excluir(int id) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("DELETE FROM adicional WHERE id=?")) {
            st.setInt(1,id); st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
    }

    public Adicional buscarPorId(int id) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM adicional WHERE id=?")) {
            st.setInt(1,id); ResultSet rs = st.executeQuery();
            if (rs.next()) return mapear(rs);
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
        return null;
    }

    private Adicional mapear(ResultSet rs) throws SQLException {
        Adicional a = new Adicional();
        a.setId(rs.getInt("id")); a.setNome(rs.getString("nome")); a.setDescricao(rs.getString("descricao"));
        a.setPreco(rs.getBigDecimal("preco")); a.setTipo(rs.getString("tipo")); a.setDisponivel(rs.getBoolean("disponivel"));
        return a;
    }
}
