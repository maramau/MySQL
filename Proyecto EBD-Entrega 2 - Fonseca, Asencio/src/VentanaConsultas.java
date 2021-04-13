import java.awt.Color;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import quick.dbtable.*;
import javax.swing.JCheckBox;
import batallas.Fechas;

/**
 * 
 * @author Fonseca, Mauro - Asencio, VIctor
 *
 */
public class VentanaConsultas extends JFrame {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTextField textFieldVueloIda1;
	private JTextField textFieldVueloIda2;
	private JTextField textFieldFechaIda;
	private DBTable tableVuelosIda;
	private DBTable tableVuelosVuelta;
	private DBTable tableAsientosIda;
	private DBTable tableAsientosVuelta;
	private JLabel lblNewLabel;
	private JLabel label;
	private JLabel lblVueloVuelta1;
	private JLabel lblVueloVuelta2;
	private JLabel label_1;
	private JTextField textFieldFechaVuelta;
	private JLabel lblDisponibilidadDeAsientos;
	private JLabel lblDisponibilidadDeAsientos_1;
	private JTextField textFieldLegajo;
	private JPasswordField textFieldClave;
	private java.sql.Connection cnx;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					VentanaConsultas frame = new VentanaConsultas();
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
	public VentanaConsultas() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 800, 400);
		contentPane = new JPanel();
		contentPane.setBackground(Color.WHITE);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblVuelosDeIda = new JLabel("Vuelos de ida");
		lblVuelosDeIda.setBounds(10, 98, 95, 20);
		contentPane.add(lblVuelosDeIda);
		
		textFieldVueloIda1 = new JTextField();
		textFieldVueloIda1.setBounds(115, 98, 100, 20);
		textFieldVueloIda1.setEnabled(false);
		contentPane.add(textFieldVueloIda1);
		textFieldVueloIda1.setColumns(10);
		
		textFieldVueloIda2 = new JTextField();
		textFieldVueloIda2.setBounds(251, 98, 100, 20);
		textFieldVueloIda2.setEnabled(false);
		contentPane.add(textFieldVueloIda2);
		textFieldVueloIda2.setColumns(10);
		
		JLabel lblA = new JLabel("a");
		lblA.setBounds(231, 98, 10, 20);
		contentPane.add(lblA);
		
		JLabel lblEnElDia = new JLabel("en el dia");
		lblEnElDia.setBounds(361, 98, 50, 20);
		contentPane.add(lblEnElDia);
		
		textFieldFechaIda = new JTextField();
		textFieldFechaIda.setBounds(421, 98, 70, 20);
		textFieldFechaIda.setEnabled(false);
		contentPane.add(textFieldFechaIda);
		textFieldFechaIda.setColumns(10);
		
		tableVuelosIda = new DBTable();
		tableVuelosIda.setForeground(Color.MAGENTA);
		tableVuelosIda.setBorder(null);
		tableVuelosIda.setBounds(10, 129, 545, 90);
		tableVuelosIda.setVisible(false);
		tableVuelosIda.setEnabled(false);
		tableVuelosIda.setEditable(false);
		tableVuelosIda.setBackground(Color.WHITE);
		contentPane.add(tableVuelosIda);
		
		lblNewLabel = new JLabel("Vuelos de vuelta");
		lblNewLabel.setBounds(10, 230, 95, 20);
		contentPane.add(lblNewLabel);
		
		tableVuelosVuelta = new DBTable();
		tableVuelosVuelta.setBackground(new Color(204, 51, 255));
		tableVuelosVuelta.setBounds(10, 261, 545, 90);
		tableVuelosVuelta.setVisible(false);
		tableVuelosVuelta.setEnabled(false);
		tableVuelosVuelta.setEditable(false);
		contentPane.add(tableVuelosVuelta);
		
		label = new JLabel("a");
		label.setBounds(231, 230, 10, 20);
		contentPane.add(label);
		
		lblVueloVuelta1 = new JLabel("");
		lblVueloVuelta1.setBounds(115, 230, 100, 20);
		contentPane.add(lblVueloVuelta1);
		
		lblVueloVuelta2 = new JLabel("");
		lblVueloVuelta2.setBounds(251, 230, 100, 20);
		contentPane.add(lblVueloVuelta2);
		
		label_1 = new JLabel("en el dia");
		label_1.setBounds(361, 230, 60, 20);
		contentPane.add(label_1);
		
		textFieldFechaVuelta = new JTextField();
		textFieldFechaVuelta.setColumns(10);
		textFieldFechaVuelta.setBounds(421, 230, 70, 20);
		textFieldFechaVuelta.setEnabled(false);
		contentPane.add(textFieldFechaVuelta);
		
		lblDisponibilidadDeAsientos = new JLabel("Disponibilidad de asientos:");
		lblDisponibilidadDeAsientos.setBounds(562, 101, 160, 20);
		contentPane.add(lblDisponibilidadDeAsientos);
		
		tableAsientosIda = new DBTable();
		tableAsientosIda.setBackground(new Color(255, 153, 255));
		tableAsientosIda.setBounds(562, 129, 212, 87);
		tableAsientosIda.setVisible(false);
		tableAsientosIda.setEnabled(false);
		tableAsientosIda.setEditable(false);
		contentPane.add(tableAsientosIda);
		
		tableAsientosVuelta = new DBTable();
		tableAsientosVuelta.setBackground(new Color(153, 51, 204));
		tableAsientosVuelta.setBounds(562, 261, 212, 87);
		tableAsientosVuelta.setVisible(false);
		tableAsientosVuelta.setEnabled(false);
		tableAsientosVuelta.setEditable(false);
		contentPane.add(tableAsientosVuelta);
		
		lblDisponibilidadDeAsientos_1 = new JLabel("Disponibilidad de asientos:");
		lblDisponibilidadDeAsientos_1.setBounds(562, 233, 160, 20);
		contentPane.add(lblDisponibilidadDeAsientos_1);
		
		JLabel lblPorFavorIngrese = new JLabel("Por favor, ingrese su legajo y clave");
		lblPorFavorIngrese.setBounds(10, 8, 532, 14);
		contentPane.add(lblPorFavorIngrese);
		
		JLabel lblLegajo = new JLabel("Legajo:");
		lblLegajo.setBounds(10, 44, 60, 20);
		contentPane.add(lblLegajo);
		
		textFieldLegajo = new JTextField();
		textFieldLegajo.setBounds(80, 44, 125, 20);
		contentPane.add(textFieldLegajo);
		//textFieldLegajo.setColumns(10);
		
		JLabel lblClave = new JLabel("Clave:");
		lblClave.setBounds(221, 44, 60, 20);
		contentPane.add(lblClave);
		
		JButton btnVerIda = new JButton("Ver");
		btnVerIda.setEnabled(false);
		btnVerIda.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//Obtengo el sql de la tabla vuelosIda
				String sqlDeLaTabla=tableVuelosIda.getSelectSql();
				String v="";
				String co="";
				String cd="";
				String hs="";
				String hll="";
				String ma="";
				String tv="";
				
				try{
					
				java.sql.Statement st=cnx.createStatement();
				
				java.sql.ResultSet rs=st.executeQuery(sqlDeLaTabla);
				
				while(rs.next()){
					
					v=rs.getString("vuelo");
					co=textFieldVueloIda1.getText();
					cd=textFieldVueloIda2.getText();
					hs=rs.getString("hora_sale");
					hll=rs.getString("hora_llega");
					ma=rs.getString("modelo_avion");
					tv=rs.getString("tiempo_vuelo");
				}
				
				String mySelect="SELECT clase, cant_asientos_disponibles, precio ";
				String myFrom="FROM vuelos_disponibles ";
				String myWhere="WHERE vuelo='"+v+"' AND ciudad_origen='"+co+"' AND ciudad_destino='"+cd+"' AND hora_sale='"+hs+"' AND hora_llega='"+hll+"' AND modelo_avion='"+ma+"' AND tiempo_vuelo='"+tv+"' ;";
				String mySql= mySelect+myFrom+myWhere;
				mySql=mySql.trim();
				
				
					//Seteo la consulta en SQL
			    	tableAsientosIda.setSelectSql(mySql);
			    	//Obtengo el modelo de la tabla  
			    	tableAsientosIda.createColumnModelFromQuery(); 
			    	//Refresco
					tableAsientosIda.refresh();
				
					//Libero los datos usados con el Statement
					st.close();
				}catch (java.sql.SQLException ex){
					ex.printStackTrace();
				}
				
			}
		});
		btnVerIda.setBounds(720, 97, 54, 23);
		contentPane.add(btnVerIda);
		
		JButton btnVerVuelta = new JButton("Ver");
		btnVerVuelta.setEnabled(false);
		btnVerVuelta.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				//Obtengo el sql de la tabla vuelosIda
				String sqlDeLaTabla=tableVuelosVuelta.getSelectSql();
				String v="";
				String co="";
				String cd="";
				String hs="";
				String hll="";
				String ma="";
				String tv="";
				
				try{
					
				java.sql.Statement st=cnx.createStatement();
				
				java.sql.ResultSet rs=st.executeQuery(sqlDeLaTabla);
				
				while(rs.next()){
					v=rs.getString("vuelo");
					co=lblVueloVuelta1.getText();
					cd=lblVueloVuelta2.getText();
					hs=rs.getString("hora_sale");
					hll=rs.getString("hora_llega");
					ma=rs.getString("modelo_avion");
					tv=rs.getString("tiempo_vuelo");
				}
				
				String mySelect="SELECT clase, cant_asientos_disponibles, precio ";
				String myFrom="FROM vuelos_disponibles ";
				String myWhere="WHERE vuelo='"+v+"' AND ciudad_origen='"+co+"' AND ciudad_destino='"+cd+"' AND hora_sale='"+hs+"' AND hora_llega='"+hll+"' AND modelo_avion='"+ma+"' AND tiempo_vuelo='"+tv+"' ;";
				String mySql= mySelect+myFrom+myWhere;
				mySql=mySql.trim();
				System.out.println(mySql);
				
				
					//Seteo la consulta en SQL
			    	tableAsientosVuelta.setSelectSql(mySql);
			    	//Obtengo el modelo de la tabla  
			    	tableAsientosVuelta.createColumnModelFromQuery(); 
			    	//Refresco
					tableAsientosVuelta.refresh();
				
					//Libero los datos usados con el Statement
					st.close();
				}catch (java.sql.SQLException ex){
					ex.printStackTrace();
				}
			}
		});
		btnVerVuelta.setBounds(720, 229, 54, 23);
		contentPane.add(btnVerVuelta);

		
		JButton btnIrIda = new JButton("Ir");
		btnIrIda.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String salida=textFieldVueloIda1.getText();
				String llegada=textFieldVueloIda2.getText();
				String fecha=textFieldFechaIda.getText();
				java.sql.Date date=Fechas.convertirStringADateSQL(fecha);
				String select="SELECT vuelo, fecha, nombre_origen, hora_sale, nombre_destino, hora_llega, modelo_avion, tiempo_vuelo ";
				String from="FROM vuelos_disponibles ";
				String where="WHERE ciudad_origen='"+salida+"' AND ciudad_destino='"+llegada+"' AND fecha='"+date+"';";
				String sql=select+" "+from+" "+where;
				sql=sql.trim();
				
				
				/*
			 	*Ejecuto la consulta correspondiente
				 */
				try{
				
					java.sql.Statement st=cnx.createStatement();
					
					if(sql.startsWith("SELECT")||sql.startsWith("select")){
						
						//Seteo la consulta en SQL
				    	tableVuelosIda.setSelectSql(sql);
				    	//Obtengo el modelo de la tabla  
				    	tableVuelosIda.createColumnModelFromQuery(); 
				    	//Refresco
						tableVuelosIda.refresh();
						
						if(!sql.equals("")) //Habilito la componente correspondiente
							btnVerIda.setEnabled(true);
					}
					else{
						st.executeUpdate(sql);
					}
					//Cierro el Statement usado
					st.close();
					
					}catch(java.sql.SQLException ex){
						lblPorFavorIngrese.setText("Ha ingresado la consulta de manera incorrecta. Por favor, intente nuevamente.");
						ex.printStackTrace();	
					}
				
				
				lblVueloVuelta1.setText(llegada);
				lblVueloVuelta2.setText(salida);
				
				//SEGUIR COMPLETANDO

			}
		});
		btnIrIda.setBounds(501, 97, 54, 23);
		contentPane.add(btnIrIda);
		btnIrIda.setEnabled(false);
		
		JLabel lblDeseoVer = new JLabel("Deseo ver:");
		lblDeseoVer.setBounds(562, 8, 100, 20);
		contentPane.add(lblDeseoVer);
		
		JCheckBox chckbxVuelosDeIda = new JCheckBox("Vuelos de ida");
		chckbxVuelosDeIda.setEnabled(false);
		chckbxVuelosDeIda.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if(chckbxVuelosDeIda.isSelected()){
					tableVuelosIda.setEnabled(true);
					tableVuelosIda.setVisible(true);
					tableAsientosIda.setVisible(true);
					tableAsientosIda.setEnabled(true);
				}
				else{
					tableVuelosIda.setEnabled(false);
					tableVuelosIda.setVisible(false);
					tableAsientosIda.setVisible(false);
					tableAsientosIda.setEnabled(false);
				}
			}
		});
		chckbxVuelosDeIda.setBounds(562, 43, 212, 25);
		contentPane.add(chckbxVuelosDeIda);
		
		JCheckBox chckbxVuelosDeVuelta = new JCheckBox("Vuelos de vuelta");
		chckbxVuelosDeVuelta.setEnabled(false);
		chckbxVuelosDeVuelta.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(chckbxVuelosDeVuelta.isSelected()){
					tableVuelosVuelta.setEnabled(true);
					tableVuelosVuelta.setVisible(true);
					tableAsientosVuelta.setVisible(true);
					tableAsientosVuelta.setEnabled(true);
				}
				else{
					tableVuelosVuelta.setEnabled(false);
					tableVuelosVuelta.setVisible(false);
					tableAsientosVuelta.setVisible(false);
					tableAsientosVuelta.setEnabled(true);
				}
			}
		});
		chckbxVuelosDeVuelta.setBounds(562, 69, 212, 25);
		contentPane.add(chckbxVuelosDeVuelta);
		//textFieldClave.setColumns(10);
		
		JButton btnIrVuelta = new JButton("Ir");
		btnIrVuelta.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String salida=lblVueloVuelta1.getText();
				String llegada=lblVueloVuelta2.getText();
				String fecha=textFieldFechaVuelta.getText();
				java.sql.Date date=Fechas.convertirStringADateSQL(fecha);
				String select="SELECT vuelo, fecha, nombre_origen, hora_sale, nombre_destino, hora_llega, modelo_avion, tiempo_vuelo ";
				String from="FROM vuelos_disponibles ";
				String where="WHERE ciudad_origen='"+salida+"' AND ciudad_destino='"+llegada+"' AND fecha='"+date+"';";
				String sql=select+" "+from+" "+where;
				sql=sql.trim();
				
				
				/*
			 	*Ejecuto la consulta correspondiente
				 */
				try{
				
					java.sql.Statement st=cnx.createStatement();
					
					if(sql.startsWith("SELECT")||sql.startsWith("select")){
						
						//Seteo la consulta en SQL
				    	tableVuelosVuelta.setSelectSql(sql);
				    	//Obtengo el modelo de la tabla  
				    	tableVuelosVuelta.createColumnModelFromQuery(); 
				    	//Refresco
						tableVuelosVuelta.refresh();
						
						if(!sql.equals("")) //Habilito la componente correspondiente
							btnVerVuelta.setEnabled(true);
					}
					else{
						st.executeUpdate(sql);
					}
					//Cierro el Statement usado
					st.close();
					
					}catch(java.sql.SQLException ex){
						lblPorFavorIngrese.setText("Ha ingresado la consulta de manera incorrecta. Por favor, intente nuevamente.");
						ex.printStackTrace();	
					}
				
				//SEGUIR COMPLETANDO
			}
		});
		btnIrVuelta.setBounds(501, 229, 54, 23);
		btnIrVuelta.setEnabled(false);
		contentPane.add(btnIrVuelta);
		
		
		
		JButton btnSalir = new JButton("Salir");
		btnSalir.setEnabled(false);
		btnSalir.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				textFieldLegajo.setEnabled(true);
				textFieldClave.setEnabled(true);
				btnSalir.setEnabled(false);
				lblPorFavorIngrese.setText("Por favor, ingrese su legajo y clave");
				
				try{
					//Cierro la conexion
					cnx.close();
					//Borro el contenido de las tablas y las deshabilito
					tableAsientosIda.removeAll();
					tableAsientosVuelta.removeAll();
					tableVuelosIda.removeAll();
					tableVuelosVuelta.removeAll();
					tableVuelosVuelta.setVisible(false);
					tableVuelosVuelta.setEnabled(false);
					tableVuelosIda.setVisible(false);
					tableVuelosIda.setEnabled(false);
					tableAsientosVuelta.setVisible(false);
					tableAsientosVuelta.setEnabled(false);
					tableAsientosIda.setVisible(false);
					tableAsientosIda.setEnabled(false);
					
					btnVerIda.setEnabled(false);
					btnVerVuelta.setEnabled(false);
					textFieldClave.setEnabled(true);
					textFieldLegajo.setEnabled(true);
					textFieldFechaIda.setEnabled(false);
					textFieldFechaVuelta.setEnabled(false);
					textFieldVueloIda1.setEnabled(false);
					textFieldVueloIda1.setText("");
					lblVueloVuelta1.setText("");
					textFieldVueloIda2.setEnabled(false);
					textFieldVueloIda2.setText("");
					lblVueloVuelta2.setText("");
					
					chckbxVuelosDeIda.setEnabled(false);
					chckbxVuelosDeVuelta.setEnabled(false);
					btnIrVuelta.setEnabled(false);
					btnIrIda.setEnabled(false);
					
				}catch(java.sql.SQLException ex){
					ex.printStackTrace();
				}
				
			}
		});
		btnSalir.setBounds(452, 43, 103, 23);
		contentPane.add(btnSalir);
		
		textFieldClave = new JPasswordField();
		textFieldClave.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				String legajo=textFieldLegajo.getText();
				String clave=textFieldClave.getText();
				String sql="SELECT legajo, password FROM empleados WHERE legajo="+legajo+";";
				
				/**
				 * Me conecto a la BD
				 */
					String driver="com.mysql.jdbc.Driver";
					String servidor="localhost";
					String puerto="3306";
					String BD="vuelos";
					String url="jdbc:mysql://"+servidor+":"+puerto+"/"+BD;
					
					try{
						//Me conecto como empleado para verificar que el par legajo/clave existe en la BD
						cnx=java.sql.DriverManager.getConnection(url,"empleado","empleado");
						java.sql.Statement st=cnx.createStatement();
						java.sql.ResultSet rs=st.executeQuery(sql);
						
						if(!rs.next() || !clave.equals(rs.getString(2))){
							//Los datos son incorrectos, me desconecto
							cnx.close();
							lblPorFavorIngrese.setText("Los datos son incorrectos. Intente nuevamente.");
						}
						else{
							/*
							 * Habilito las coponentes correspondientes
							 */
							lblPorFavorIngrese.setText("Ha ingresado con exito. Bienvenido "+legajo+".");
							textFieldClave.setText("");
							textFieldClave.setEnabled(false);
							textFieldLegajo.setText("");
							textFieldLegajo.setEnabled(false);
							textFieldVueloIda1.setEnabled(true);
							textFieldVueloIda2.setEnabled(true);
							textFieldFechaIda.setEnabled(true);
							textFieldFechaVuelta.setEnabled(true);
							btnSalir.setEnabled(true);
							btnIrIda.setEnabled(true);
							btnIrVuelta.setEnabled(true);
							chckbxVuelosDeIda.setEnabled(true);
							chckbxVuelosDeVuelta.setEnabled(true);
							chckbxVuelosDeIda.setVisible(true);
							chckbxVuelosDeVuelta.setVisible(true);
							
							/*
							 * Conecto las tablas
							 */
							//Conecto las tablas
							tableVuelosIda.connectDatabase(driver, url, "empleado", "empleado");
							tableVuelosVuelta.connectDatabase(driver, url, "empleado", "empleado");
							tableAsientosIda.connectDatabase(driver, url, "empleado", "empleado");
							tableAsientosVuelta.connectDatabase(driver, url, "empleado", "empleado");
						}
						//Libero los datos usados con el Statement
						st.close();
						
					}catch (java.sql.SQLException e){
						lblPorFavorIngrese.setText("Los datos son incorrectos. Intente nuevamente.");
					}catch (ClassNotFoundException e){
						e.printStackTrace();
					}
			}
		});
		textFieldClave.setBounds(291, 44, 125, 20);
		contentPane.add(textFieldClave);
	}
}
