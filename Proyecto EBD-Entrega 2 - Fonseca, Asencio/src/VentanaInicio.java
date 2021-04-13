import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import javax.swing.JButton;
import java.awt.Color;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

/**
 * 
 * @author Fonseca, Mauro - Asencio, VIctor
 *
 */
public class VentanaInicio extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					VentanaInicio frame = new VentanaInicio();
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
	public VentanaInicio() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 269, 230);
		contentPane = new JPanel();
		contentPane.setBackground(Color.WHITE);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblleGustaraAcceder = new JLabel("\u00BFAcceder como empleado o como administrador?");
		lblleGustaraAcceder.setBounds(5, 5, 250, 14);
		contentPane.add(lblleGustaraAcceder);
		
		JButton btnAccederComoEmpleado = new JButton("Acceder como empleado");
		JButton btnAccederComoAdministrador = new JButton("Acceder como administrador");
		btnAccederComoAdministrador.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				btnAccederComoEmpleado.setEnabled(false);
				btnAccederComoAdministrador.setEnabled(false);
				JFrame va= new VentanaAdmin();
				va.setLocation(20, 20);
				va.setVisible(true);
			}
		});
		btnAccederComoAdministrador.setBackground(Color.WHITE);
		btnAccederComoAdministrador.setBounds(26, 30, 200, 80);
		contentPane.add(btnAccederComoAdministrador);
		
		
		btnAccederComoEmpleado.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				btnAccederComoEmpleado.setEnabled(false);
				btnAccederComoAdministrador.setEnabled(false);
				JFrame vc=new VentanaConsultas();
				vc.setLocation(20, 20);
				vc.setVisible(true);
			}
		});
		btnAccederComoEmpleado.setBackground(Color.WHITE);
		btnAccederComoEmpleado.setBounds(26, 110, 200, 80);
		contentPane.add(btnAccederComoEmpleado);
	}

}
