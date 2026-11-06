import streamlit as st

# --------------------------------
# 1. Page Configuration
# --------------------------------
st.set_page_config(
    page_title="Business Interest Calculator",
    page_icon="💰",
    layout="centered"
)

# --------------------------------
# 2. Application Title
# --------------------------------
st.title("💰 Business Simple Interest Calculator")

st.write(
    "Calculate the interest on a business loan "
    "or investment using the simple interest formula."
)

st.divider()

# --------------------------------
# 3. Collect User Inputs
# --------------------------------
st.subheader("Enter Financial Details")

principal = st.number_input(
    "Principal Amount (₦)",
    min_value=0.0,
    value=100000.0,
    step=10000.0
)

rate = st.number_input(
    "Annual Interest Rate (%)",
    min_value=0.0,
    value=10.0,
    step=1.0
)

time = st.number_input(
    "Duration (Years)",
    min_value=0.0,
    value=2.0,
    step=0.5
)

# --------------------------------
# 4. Calculate Simple Interest
# --------------------------------
if st.button("Calculate Interest", type="primary"):

    if principal <= 0 or time <= 0:
        st.error("Please enter a principal amount and duration greater than zero.")

    else:
        # Simple Interest Formula
        interest = (principal * rate * time) / 100

        # Calculate Total Amount
        total_amount = principal + interest

        # --------------------------------
        # 5. Display Results
        # --------------------------------
        st.success("Calculation Completed Successfully!")

        st.subheader("Business Financial Summary")

        col1, col2 = st.columns(2)

        with col1:
            st.metric(
                "Principal Amount",
                f"₦{principal:,.2f}"
            )

            st.metric(
                "Interest Payable",
                f"₦{interest:,.2f}"
            )

        with col2:
            st.metric(
                "Interest Rate",
                f"{rate:.2f}%"
            )

            st.metric(
                "Total Amount",
                f"₦{total_amount:,.2f}"
            )

        st.info(
            f"Over {time:g} years, the interest on your "
            f"₦{principal:,.2f} is ₦{interest:,.2f}. "
            f"The total amount is ₦{total_amount:,.2f}."
        )

        st.caption(
            "Note: This calculator assumes a fixed annual "
            "simple interest rate, without compounding."
        )