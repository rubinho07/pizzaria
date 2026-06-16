package dao;
import model.Pizza;
import util.Conexao;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

public class PizzaDAO {

    public void inserir(Pizza p) {
        String sql = "INSERT INTO pizza (nome,descricao,tamanho,categoria,preco,disponivel,ingredientes,imagem_url,tempo_preparo,calorias,vegana,sem_gluten) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1,p.getNome()); st.setString(2,p.getDescricao()); st.setString(3,p.getTamanho());
            st.setString(4,p.getCategoria()); st.setBigDecimal(5,p.getPreco()); st.setBoolean(6,p.isDisponivel());
            st.setString(7,p.getIngredientes()); st.setString(8,p.getImagemUrl());
            st.setInt(9,p.getTempoPreparo()); st.setInt(10,p.getCalorias());
            st.setBoolean(11,p.isVegana()); st.setBoolean(12,p.isSemGluten());
            st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro ao inserir pizza: "+e.getMessage(),e); }
    }

    public void alterar(Pizza p) {
        String sql = "UPDATE pizza SET nome=?,descricao=?,tamanho=?,categoria=?,preco=?,disponivel=?,ingredientes=?,imagem_url=?,tempo_preparo=?,calorias=?,vegana=?,sem_gluten=? WHERE id=?";
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1,p.getNome()); st.setString(2,p.getDescricao()); st.setString(3,p.getTamanho());
            st.setString(4,p.getCategoria()); st.setBigDecimal(5,p.getPreco()); st.setBoolean(6,p.isDisponivel());
            st.setString(7,p.getIngredientes()); st.setString(8,p.getImagemUrl());
            st.setInt(9,p.getTempoPreparo()); st.setInt(10,p.getCalorias());
            st.setBoolean(11,p.isVegana()); st.setBoolean(12,p.isSemGluten());
            st.setInt(13,p.getId());
            st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro ao alterar pizza: "+e.getMessage(),e); }
    }

    public void excluir(int id) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("DELETE FROM pizza WHERE id=?")) {
            st.setInt(1,id); st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro ao excluir pizza: "+e.getMessage(),e); }
    }

    public Pizza buscarPorId(int id) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM pizza WHERE id=?")) {
            st.setInt(1,id); ResultSet rs = st.executeQuery();
            if (rs.next()) return mapear(rs);
        } catch (Exception e) { throw new RuntimeException("Erro ao buscar pizza: "+e.getMessage(),e); }
        return null;
    }

    public List<Pizza> listarTodos() {
        List<Pizza> lista = new ArrayList<>();
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM pizza ORDER BY categoria, nome"); ResultSet rs = st.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (Exception e) { throw new RuntimeException("Erro ao listar pizzas: "+e.getMessage(),e); }
        return lista;
    }

    public List<Pizza> listarDisponiveis() {
        List<Pizza> lista = new ArrayList<>();
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM pizza WHERE disponivel=true ORDER BY categoria, nome"); ResultSet rs = st.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (Exception e) { throw new RuntimeException("Erro ao listar: "+e.getMessage(),e); }
        return lista;
    }

    private Pizza mapear(ResultSet rs) throws SQLException {
        Pizza p = new Pizza();
        p.setId(rs.getInt("id")); p.setNome(rs.getString("nome")); p.setDescricao(rs.getString("descricao"));
        p.setTamanho(rs.getString("tamanho")); p.setCategoria(rs.getString("categoria"));
        p.setPreco(rs.getBigDecimal("preco")); p.setDisponivel(rs.getBoolean("disponivel"));
        p.setIngredientes(rs.getString("ingredientes")); p.setImagemUrl(rs.getString("imagem_url"));
        p.setTempoPreparo(rs.getInt("tempo_preparo")); p.setCalorias(rs.getInt("calorias"));
        p.setVegana(rs.getBoolean("vegana")); p.setSemGluten(rs.getBoolean("sem_gluten"));
        return p;
    }
}
