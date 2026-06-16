package dao;
import model.Pedido;
import model.ItemPedido;
import util.Conexao;
import java.sql.*;
import java.util.*;

public class PedidoDAO {

    public int inserir(Pedido p) {
        String sql = "INSERT INTO pedido (nome_cliente,telefone_cliente,endereco_entrega,forma_pagamento,status,total_bruto,total_final,desconto,observacao,data_pedido) VALUES (?,?,?,?,?,?,?,?,?,NOW())";
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1,p.getNomeCliente()); st.setString(2,p.getTelefoneCliente());
            st.setString(3,p.getEnderecoEntrega()); st.setString(4,p.getFormaPagamento());
            st.setString(5,p.getStatus() != null ? p.getStatus() : "AGUARDANDO");
            st.setBigDecimal(6,p.getTotalBruto()); st.setBigDecimal(7,p.getTotalFinal());
            st.setBigDecimal(8,p.getDesconto()); st.setString(9,p.getObservacao());
            st.executeUpdate();
            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { throw new RuntimeException("Erro ao inserir pedido: "+e.getMessage(),e); }
        return 0;
    }

    public void inserirItem(ItemPedido item) {
        String sql = "INSERT INTO item_pedido (pedido_id,pizza_id,nome_pizza,quantidade,preco_unitario,preco_final,subtotal,adicionais,observacao) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1,item.getPedidoId()); st.setInt(2,item.getPizzaId());
            st.setString(3,item.getNomePizza()); st.setInt(4,item.getQuantidade());
            st.setBigDecimal(5,item.getPrecoUnitario()); st.setBigDecimal(6,item.getPrecoFinal());
            st.setBigDecimal(7,item.getSubtotal()); st.setString(8,item.getAdicionais());
            st.setString(9,item.getObservacao());
            st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro ao inserir item: "+e.getMessage(),e); }
    }

    public List<Pedido> listarTodos() {
        List<Pedido> lista = new ArrayList<>();
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM pedido ORDER BY id DESC"); ResultSet rs = st.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
        return lista;
    }

    public Pedido buscarPorId(int id) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM pedido WHERE id=?")) {
            st.setInt(1,id); ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Pedido p = mapear(rs);
                p.setItens(listarItensDoPedido(id));
                return p;
            }
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
        return null;
    }

    public void atualizarStatus(int id, String status) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("UPDATE pedido SET status=? WHERE id=?")) {
            st.setString(1,status); st.setInt(2,id); st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
    }

    public void excluir(int id) {
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("DELETE FROM pedido WHERE id=?")) {
            st.setInt(1,id); st.executeUpdate();
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
    }

    private List<ItemPedido> listarItensDoPedido(int pedidoId) {
        List<ItemPedido> lista = new ArrayList<>();
        try (Connection con = Conexao.getConexao(); PreparedStatement st = con.prepareStatement("SELECT * FROM item_pedido WHERE pedido_id=?")) {
            st.setInt(1,pedidoId); ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ItemPedido i = new ItemPedido();
                i.setId(rs.getInt("id")); i.setPedidoId(rs.getInt("pedido_id"));
                i.setPizzaId(rs.getInt("pizza_id")); i.setNomePizza(rs.getString("nome_pizza"));
                i.setQuantidade(rs.getInt("quantidade")); i.setPrecoUnitario(rs.getBigDecimal("preco_unitario"));
                i.setPrecoFinal(rs.getBigDecimal("preco_final")); i.setSubtotal(rs.getBigDecimal("subtotal"));
                i.setAdicionais(rs.getString("adicionais")); i.setObservacao(rs.getString("observacao"));
                lista.add(i);
            }
        } catch (Exception e) { throw new RuntimeException("Erro: "+e.getMessage(),e); }
        return lista;
    }

    private Pedido mapear(ResultSet rs) throws SQLException {
        Pedido p = new Pedido();
        p.setId(rs.getInt("id")); p.setNomeCliente(rs.getString("nome_cliente"));
        p.setTelefoneCliente(rs.getString("telefone_cliente")); p.setEnderecoEntrega(rs.getString("endereco_entrega"));
        p.setFormaPagamento(rs.getString("forma_pagamento")); p.setStatus(rs.getString("status"));
        p.setTotalBruto(rs.getBigDecimal("total_bruto")); p.setTotalFinal(rs.getBigDecimal("total_final"));
        p.setDesconto(rs.getBigDecimal("desconto")); p.setObservacao(rs.getString("observacao"));
        p.setDataPedido(rs.getString("data_pedido"));
        return p;
    }
}
