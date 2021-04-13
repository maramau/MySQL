import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JTextField;
import java.awt.Color;
import java.awt.Font;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.Dimension;
import javax.swing.JComboBox;
import quick.dbtable.*;

/**
 * 
 * @author Fonseca, Mauro - Asencio, VIctor
 *
 */

public class VentanaAdmin extends JFrame {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JPasswordField textFieldPassword;
	private JTextField textFieldQuery;

	private DBTable table;
	private java.sql.Connection cnx;
	private String query;

	/**
	 * Launch the application.
	 */
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					VentanaAdmin frame = new VentanaAdmin();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	/**
	 * Create the frame.
	 */
	public VentanaAdmin() {
		setSize(new Dimension(640, 495));

		
		setBackground(new Color(100, 149, 237));
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 640, 495);
		contentPane = new JPanel();
		contentPane.setBackground(new Color(255, 255, 255));
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblPorFavorIngrese = new JLabel("Por favor ingrese sus datos:");
		lblPorFavorIngrese.setForeground(new Color(60, 179, 113));
		lblPorFavorIngrese.setFont(new Font("Tahoma", Font.PLAIN, 13));
		lblPorFavorIngrese.setBackground(new Color(123, 104, 238));
		lblPorFavorIngrese.setBounds(10, 0, 650, 20);
		contentPane.add(lblPorFavorIngrese);
		
		JLabel lblUsuario = new JLabel("Usuario:");
		lblUsuario.setForeground(new Color(46, 139, 87));
		lblUsuario.setBounds(10, 28, 50, 25);
		contentPane.add(lblUsuario);
		
		JLabel lblContrasea = new JLabel("Clave:");
		lblContrasea.setForeground(new Color(46, 139, 87));
		lblContrasea.setBounds(166, 28, 50, 25);
		contentPane.add(lblContrasea);
		
		JLabel labelAtributes = new JLabel();
		labelAtributes.setVisible(true);
		labelAtributes.setForeground(new Color(221, 160, 221));
		labelAtributes.setBackground(new Color(250, 250, 210));
		labelAtributes.setBounds(451, 89, 163, 357);
		contentPane.add(labelAtributes);
		
		JComboBox<String> comboBoxTablas = new JComboBox<String>();
		comboBoxTablas.setVisible(false);
		comboBoxTablas.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				/*
				 * CUANDO ELIJA ALGUN ITEM DEBO MOSTRAR SUS ATRIBUTOS EN LA JLabel
				 */
				
				String sql="DESCRIBE "+(String) comboBoxTablas.getSelectedItem();
				try{
					java.sql.Statement st=cnx.createStatement();
					java.sql.ResultSet rs=st.executeQuery(sql);
					String cadena="<html><body>";
					
					while(rs.next()){
						cadena+=rs.getString(1)+" <br>";
						//Esto es HTML ¿que onda java.swing?
					}
					cadena+="</html></body>";
					labelAtributes.setText(cadena);
					
					//Libero los datos usados con el Statement
					st.close();
					
				}catch(java.sql.SQLException e){
					// en caso de error, se muestra la causa en la consola
			         System.out.println("SQLException: " + e.getMessage());
			         System.out.println("SQLState: " + e.getSQLState());
			         System.out.println("VendorError: " + e.getErrorCode());
				}
				
				
			}
		});
		comboBoxTablas.setBounds(451, 58, 163, 20);
		contentPane.add(comboBoxTablas);
		
		JButton btnSalir = new JButton("Salir");
		btnSalir.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				try{
					//Cierro la conexion
					cnx.close();
					
					//Actualizo las componentes graficas
					btnSalir.setEnabled(false);
					textFieldPassword.setText("");
					textFieldPassword.setEnabled(true);
					textFieldQuery.setText("");
					textFieldQuery.setEnabled(false);
					labelAtributes.setText("");
					table.removeAll();
					table.setVisible(false);
					comboBoxTablas.removeAll();
					comboBoxTablas.setEnabled(false);
					comboBoxTablas.setVisible(false);
					lblPorFavorIngrese.setText("Por favor ingrese sus datos:");
					
				}catch(java.sql.SQLException ex){
					// en caso de error, se muestra la causa en la consola
			         System.out.println("SQLException: " + ex.getMessage());
			         System.out.println("SQLState: " + ex.getSQLState());
			         System.out.println("VendorError: " + ex.getErrorCode());
				}
			}
		});
		
		btnSalir.setBounds(327, 25, 100, 25);
		btnSalir.setEnabled(false);
		contentPane.add(btnSalir);
		
		textFieldQuery = new JTextField();
		textFieldQuery.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				query= textFieldQuery.getText().trim();
				
				/*
			 	*Ejecuto la consulta correspondiente
				 */
				try{
				
					java.sql.Statement st=cnx.createStatement();
					 
					if(query.startsWith("SELECT")||query.startsWith("select")){
						
						//Seteo la consulta en SQL
				    	table.setSelectSql(query);  
				    	//Obtengo el modelo de la tabla  
				    	table.createColumnModelFromQuery(); 
				    	//Refresco
						table.refresh();
					}
					else{
						st.executeUpdate(query);
					}
					//Cierro el Statement usado
					st.close();
					
					}catch(java.sql.SQLException ex){
						lblPorFavorIngrese.setText("Ha ingresado la consulta de manera incorrecta. Por favor, intente nuevamente.");
						// en caso de error, se muestra la causa en la consola
				         System.out.println("SQLException: " + ex.getMessage());
				         System.out.println("SQLState: " + ex.getSQLState());
				         System.out.println("VendorError: " + ex.getErrorCode());
					}
			}
		});
		textFieldQuery.setForeground(new Color(46, 139, 87));
		textFieldQuery.setBackground(Color.WHITE);
		textFieldQuery.setEnabled(false);
		textFieldQuery.setText("Ingrese en este lugar la consulta deseada");
		textFieldQuery.setBounds(10, 56, 431, 134);
		contentPane.add(textFieldQuery);
		textFieldQuery.setColumns(10);
		
		table = new DBTable();
		table.setBackground(Color.LIGHT_GRAY);
		table.setBounds(10, 221, 431, 225);
		contentPane.add(table);
		table.setEditable(false);
		table.setVisible(false);
		
		textFieldPassword = new JPasswordField();
		textFieldPassword.setBounds(226, 28, 80, 25);
		contentPane.add(textFieldPassword);
		textFieldPassword.setColumns(10);
		
		JLabel lblAdmin = new JLabel("admin");
		lblAdmin.setEnabled(false);
		lblAdmin.setBounds(76, 30, 80, 20);
		contentPane.add(lblAdmin);
		textFieldPassword.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				String user=lblAdmin.getText();
				@SuppressWarnings("deprecation")
				String password=textFieldPassword.getText();
				
				/**
				 * Me conecto a la BD
				 */
					String driver="com.mysql.jdbc.Driver";
					String servidor="localhost";
					String puerto="3306";
					String BD="vuelos";
					String url="jdbc:mysql://"+servidor+":"+puerto+"/"+BD;
					
					try{
						table.setVisible(true);
						table.setEnabled(true);
						cnx=java.sql.DriverManager.getConnection(url,user,password);
						table.connectDatabase(driver, url, user, password);
						
						lblPorFavorIngrese.setText("Bienvenido.");
						textFieldQuery.setEnabled(true);
						textFieldQuery.setText(null);
						textFieldPassword.setEnabled(false);
						btnSalir.setEnabled(true);
						comboBoxTablas.setVisible(true);
						comboBoxTablas.setEnabled(true);
						
						
						/*
						 * INICIO EL COMBO BOX CON LAS TABLAS DE LA BD
						 */
						
						String sql="SHOW FULL TABLES FROM vuelos";
						
						java.sql.Statement st=cnx.createStatement();
						java.sql.ResultSet rs=st.executeQuery(sql);
							
						while(rs.next()){
							comboBoxTablas.addItem(rs.getString(1));
						}
						
						//Cierro el Statement
						st.close();
						
					}catch (java.sql.SQLException ex){
						// en caso de error, se muestra la causa en la consola
				         System.out.println("SQLException: " + ex.getMessage());
				         System.out.println("SQLState: " + ex.getSQLState());
				         System.out.println("VendorError: " + ex.getErrorCode());
						lblPorFavorIngrese.setText("Datos incorrectos. Pruebe de nuevo.");
					}catch (ClassNotFoundException ex){
						ex.printStackTrace();
					}
			}
		});

	}
}
