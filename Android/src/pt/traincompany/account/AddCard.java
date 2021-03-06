package pt.traincompany.account;

import java.lang.reflect.Field;
import java.util.Calendar;

import org.json.JSONObject;

import pt.traincompany.main.R;
import pt.traincompany.utility.Configurations;
import pt.traincompany.utility.Connection;
import pt.traincompany.utility.Utility;
import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

public class AddCard extends Dialog {

	Context context;

	public AddCard(Context context) {
		super(context);
		this.context = context;

	}

	ProgressDialog dialog;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_add_card);

		DatePicker picker = (DatePicker) findViewById(R.id.expiryDate);
		try {
			Field f[] = picker.getClass().getDeclaredFields();
			for (Field field : f) {
				if (field.getName().equals("mDayPicker") || field.getName().equals("mDaySpinner")) {
					field.setAccessible(true);
					Object dayPicker = field.get(picker);
					((View) dayPicker).setVisibility(View.GONE);
				}
			}
		} catch (SecurityException e) {
			Log.d("ERROR", e.getMessage());
		} catch (IllegalArgumentException e) {
			Log.d("ERROR", e.getMessage());
		} catch (IllegalAccessException e) {
			Log.d("ERROR", e.getMessage());
		}

		final Button addCard = (Button) findViewById(R.id.btnAddCard);
		addCard.setOnClickListener(new View.OnClickListener() {
			public void onClick(View v) {

				final Calendar c = Calendar.getInstance();
		        int mYear = c.get(Calendar.YEAR);
		        int mMonth = c.get(Calendar.MONTH);
		        int mDay = c.get(Calendar.DAY_OF_MONTH);
		        c.set(mYear, mMonth, mDay);
		        
		        DatePicker datePicker = (DatePicker) findViewById(R.id.expiryDate);
		        
		        final Calendar c2 = Calendar.getInstance();
		        c2.set(datePicker.getYear(), datePicker.getMonth(), 31);
		        

				EditText number = (EditText) findViewById(R.id.cardNumber);
				EditText cvv = (EditText) findViewById(R.id.cvv);

				if (number.getText().toString().equals("") || number.getText().toString().trim().length() != 16) {
					Toast.makeText(context,
							"O número do cartão não é válido!",
							Toast.LENGTH_LONG).show();
				}
				else if (cvv.getText().toString().equals("") || cvv.getText().toString().trim().length() != 3) {
					Toast.makeText(context,
							"O número de segurança não é válido!",
							Toast.LENGTH_LONG).show();
				}
				else if (c.after(c2)) {
					Toast.makeText(context,
							"A data não é válida!",
							Toast.LENGTH_LONG).show();
				}
				else {
					Spinner type = (Spinner) findViewById(R.id.cardType);
					
					dialog = ProgressDialog.show(context, "",
							"A comunicar com o servidor...", true);
					dialog.setCancelable(true);

					DatePicker date = (DatePicker) findViewById(R.id.expiryDate);
					AddCardToUser ac = new AddCardToUser(number.getText()
							.toString(), cvv.getText().toString(), type.getSelectedItem().toString(),
							date.getMonth(), date.getYear());
					new Thread(ac).start();
				}
			}
		});
	}

	private void communicationProblem() {
		dialog.dismiss();
		((Activity) context).runOnUiThread(new Runnable() {
			public void run() {
				Toast.makeText(context,
						"A comunicação com o servidor falhou...",
						Toast.LENGTH_LONG).show();
			}
		});

		AddCard.this.dismiss();
	}

	class AddCardToUser implements Runnable {

		public String number, type, cvv;
		public int month, year;

		public AddCardToUser(String number, String cvv, String type, int month, int year) {
			this.number = number;
			this.cvv = cvv;
			this.type = type;
			this.month = month;
			this.year = year;
		}

		public void run() {
			Uri.Builder uri = Uri.parse("http://" + Configurations.AUTHORITY)
					.buildUpon();
			uri.path(Configurations.ADDCARD);
			uri.appendQueryParameter("format", Configurations.FORMAT);
			uri.appendQueryParameter("number", number);
			uri.appendQueryParameter("type", type);
			uri.appendQueryParameter("cvv", cvv);
			uri.appendQueryParameter("user_id", Configurations.userId + "");
			uri.appendQueryParameter("validity", "1-" + month + "-" + year);

			String response = null;

			try {
				response = Connection.getJSONLine(uri.build());

				JSONObject info = new JSONObject(response);
				String status = info.getString("status");

				if (status.equals("OK")) {

					Card c = new Card(info.getInt("id"), number);
					Utility.user_cards.add(c);

					((Activity) context).runOnUiThread(new Runnable() {
						public void run() {

							dialog.dismiss();
							Toast.makeText(context,
									"Cartão adicinado com sucesso!",
									Toast.LENGTH_LONG).show();

							CardAdapter adapter = new CardAdapter(
									context,
									R.layout.creditcard_row,
									R.drawable.ic_launcher,
									Utility.user_cards
											.toArray(new Card[Utility.user_cards
													.size()]));

							ListView list = (ListView) ((Activity) context)
									.findViewById(R.id.creditCards);
							list.setAdapter(adapter);

						}
					});

					AddCard.this.dismiss();

				} else {
					((Activity) context).runOnUiThread(new Runnable() {
						public void run() {
							dialog.dismiss();
							Toast.makeText(context,
									"Já existe um cartão com esse número.",
									Toast.LENGTH_LONG).show();
						}
					});
				}
			} catch (Exception e) {
				communicationProblem();
			}
		}
	}
}
