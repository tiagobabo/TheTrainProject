package pt.traincompany.searchHistory;

import java.util.ArrayList;

import pt.traincompany.main.DatabaseHelper;
import pt.traincompany.main.R;
import pt.traincompany.utility.Configurations;
import android.app.Activity;
import android.app.ProgressDialog;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;

public class MyHistory extends Activity {
	
	ProgressDialog dialog;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_my_history);

		dialog = ProgressDialog.show(MyHistory.this, "",
				"A comunicar com o servidor...", true);
		dialog.setCancelable(true);
		
		ArrayList<SearchQuery> queries = readDatabase();
		
		SearchQueryAdapter adapter = new SearchQueryAdapter(
				MyHistory.this, R.layout.history_row,
				queries
						.toArray(new SearchQuery[queries
								.size()]));
		
		final ListView list = (ListView) findViewById(R.id.myHistory);

		View header = (View) getLayoutInflater().inflate(
				R.layout.history_header, null);

		list.addHeaderView(header);
		list.setAdapter(adapter);
		
		dialog.dismiss();

	}

	public ArrayList<SearchQuery> readDatabase() {

		ArrayList<SearchQuery> history = new ArrayList<SearchQuery>();

		DatabaseHelper helper = Configurations.databaseHelper;
		SQLiteDatabase db = helper.getWritableDatabase();
		Cursor cursor = db.query("SearchHistory",
				new String[] { "departure, arrival, hours, date" }, "departure IS NOT NULL AND arrival IS NOT NULL and userId = ?", new String[] {Configurations.userId+""}, null,
				null, "date DESC");
		
		if (cursor.moveToFirst()) {
			do{
				SearchQuery s = new SearchQuery(cursor.getString(0),
						cursor.getString(1), cursor.getString(2), cursor.getString(3));
				history.add(s);
			}while (cursor.moveToNext());
		}

		db.close();
		return history;

	}

}
