import numpy as np
import tensorflow as tf
from tensorflow.keras.layers import Dense, Dropout, Input


def load_data():
    # Load data in any convenient way, here raw data
    x = np.array(
        [
            [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0], 
            [1.0,1.0,0.0,1.0,1.0,0.0,1.0,1.0,1.0,1.0,1.0,0.0,1.0], 
            [0.0,0.0,1.0,0.0,1.0,1.0,0.0,1.0,1.0,1.0,0.0,0.0,1.0], 
            [0.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0,1.0,1.0,1.0,0.0,1.0],
            [0.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,1.0,0.0,1.0,0.0,1.0], 
            [0.0,1.0,1.0,0.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0,0.0,1.0],
            [1.0,1.0,0.0,1.0,1.0,1.0,0.0,1.0,1.0,1.0,1.0,0.0,1.0], 
            [0.0,1.0,1.0,1.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0], 
            [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0], 
            [0.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0], 
            [0.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0,1.0],
            [0.0,1.0,1.0,0.0,1.0,0.0,1.0,1.0,1.0,0.0,1.0,0.0,1.0], 
            [1.0,0.0,0.0,1.0,1.0,0.0,0.0,1.0,0.0,0.0,1.0,0.0,0.0], 
            [1.0,1.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0,1.0,1.0,1.0,1.0], 
            [0.0,1.0,0.0,1.0,0.0,0.0,0.0,1.0,1.0,0.0,0.0,0.0,0.0],
            [0.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.0,1.0,0.0,1.0], 
            [0.0,0.0,0.0,0.0,1.0,1.0,1.0,0.0,1.0,0.0,0.0,0.0,1.0],
            [0.0,1.0,1.0,1.0,1.0,0.0,0.0,1.0,1.0,1.0,1.0,0.0,1.0], 
            [0.0,0.0,1.0,1.0,1.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0], 
            [0.0,0.0,1.0,0.0,0.0,1.0,0.0,1.0,1.0,0.0,1.0,0.0,0.0], 
            [1.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0,1.0,1.0,0.0,1.0,1.0], 
            [1.0,1.0,0.0,1.0,1.0,1.0,0.0,1.0,1.0,1.0,1.0,0.0,1.0], 
            [0.0,1.0,1.0,1.0,1.0,0.0,0.0,0.0,1.0,1.0,1.0,0.0,1.0]
        ],
        dtype=np.float32
    )
    y =  np.array(
        [
            [1.0],
            [1.0],
            [0.0],
            [1.0],
            [0.0],
            [1.0],
            [1.0],
            [0.0],
            [1.0],
            [1.0],
            [1.0],
            [0.0],
            [0.0],
            [1.0],
            [0.0],
            [1.0],
            [0.0],
            [1.0],
            [0.0],
            [0.0],
            [1.0],
            [1.0],
            [0.0],
        ],
        dtype=np.float32
    )
    return x, y

def build_ds(x, y, val_split=0.2, batch_size=4):
    # 20% of data for validation
    test_split = 0.2
    total_size = len(x)
    test_size = np.ceil(total_size*test_split)
    train_size = total_size - test_size
    # Create tf dataset
    ds = tf.data.Dataset.from_tensor_slices(({'inputs': x}, {'outputs':y}))
    # Shuffle data
    ds = ds.shuffle(total_size)
    # Split on train & test + batch
    train_ds = ds.take(train_size).batch(batch_size)
    test_ds = ds.skip(test_size).batch(batch_size)
    return train_ds, test_ds


def build_model(inp_shape):
    # Build core parts
    inp =  Input(shape=inp_shape, name='inputs')
    x =  Dense(64, activation='relu')(inp)
    x =  Dropout(0.25)(x)
    x =  Dense(64, activation='relu')(x)
    x =  Dropout(0.25)(x)
    x =  Dense(64, activation='relu')(x)
    x =  Dropout(0.25)(x)
    x =  Dense(64, activation='relu')(x)
    x =  Dropout(0.25)(x)
    preds =  Dense(1, activation='sigmoid', name='outputs')(x)
    # Build model itself
    model = tf.keras.Model(inputs=inp, outputs=preds)
    # Compile and return
    model.compile(
        optimizer='adam',
        loss='binary_crossentropy',
        metrics=['accuracy']
    )
    return model

def main():
    # Load data & create ds
    x, y = load_data()
    train_ds, test_ds = build_ds(x, y)
    # Build model
    model = build_model(x.shape[1])
    # Stop training when the val accuracy have not improved for last 50 epochs
    early_stopping = tf.keras.callbacks.EarlyStopping(patience=50, min_delta=1e-3)
    # Train model
    history = model.fit(
        train_ds,
        validation_data=test_ds,
        epochs=1000,
        callbacks=[early_stopping]
    )
    model.save('model.h5')
