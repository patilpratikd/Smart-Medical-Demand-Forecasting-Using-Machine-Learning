import streamlit as st
import pickle
from datetime import datetime
import pandas as pd
from prophet import Prophet

# Load the models from pickle files
with open('C:/Users/Dell Latitude 5490/OneDrive/Documents/UT18/PANTOPRAZOLE 40MG INJ_model.pkl', 'rb') as file:
    model_1 = pickle.load(file)

with open('C:/Users/Dell Latitude 5490/OneDrive/Documents/UT18/CEFTRIAXONE 1GM_model.pkl', 'rb') as file:
    model_2 = pickle.load(file)

with open('C:/Users/Dell Latitude 5490/OneDrive/Documents/UT18/LIGNOCAINE HYDROCHLORIDE 2% INJ_model.pkl', 'rb') as file:
    model_3 = pickle.load(file)

with open('C:/Users/Dell Latitude 5490/OneDrive/Documents/UT18/PARACETAMOL 150MG_model.pkl', 'rb') as file:
    model_4 = pickle.load(file)

with open('C:/Users/Dell Latitude 5490/OneDrive/Documents/UT18/SODIUM CHLORIDE 0.9%_model.pkl', 'rb') as file:
    model_5 = pickle.load(file)

st.title("Drug Demand Forecasting App")

# Add logo image
st.image("C:/Users/Dell Latitude 5490/Downloads/Logo.jpg", use_column_width=True)

# Create a dropdown for selecting the drug
drug_name = st.selectbox("Select the drug", ["PANTOPRAZOLE 40MG INJ", "CEFTRIAXONE 1GM", "LIGNOCAINE HYDROCHLORIDE 2% INJ_model", "PARACETAMOL 150MG", "SODIUM CHLORIDE 0.9%"])

# Load the corresponding model based on drug_name
if drug_name == 'PANTOPRAZOLE 40MG INJ':
    model = model_1
elif drug_name == 'CEFTRIAXONE 1GM':
    model = model_2
elif drug_name == 'LIGNOCAINE HYDROCHLORIDE 2% INJ_model':
    model = model_3
elif drug_name == 'PARACETAMOL 150MG':
    model = model_4
elif drug_name == 'SODIUM CHLORIDE 0.9%':
    model = model_5
else:
    st.error("We don't have this Drug")
    st.stop()

# Create a button for forecasting
if st.button("Forecast"):
    try:
        # Create a future dataframe for the next month
        future = model.make_future_dataframe(periods=30, freq='D')

        # Make predictions
        forecast = model.predict(future)

        # Extract the predicted values for the next month
        predictions = forecast['yhat'][-30:].tolist()

        # Define custom labels for past and future weeks
        past_labels = [f"Past Week {i+1}" for i in range(10)]
        future_labels = [f"Future Week {i+1}" for i in range(20)]

        # Combine labels for display
        labels = past_labels + future_labels

        # Display the predictions with custom labels
        st.write({
            "drug_name": drug_name,
            "predictions": dict(zip(labels, predictions))
        })

    except Exception as e:
        st.error(str(e))

