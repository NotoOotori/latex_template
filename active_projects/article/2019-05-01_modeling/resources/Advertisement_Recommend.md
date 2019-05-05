import pandas as pd
from sklearn.model_selection import train_test_split
import numpy as np
from collections import Counter
import tensorflow as tf

import os
import pickle
import re
from tensorflow.python.ops import math_ops

users_title = ['UserID', 'Gender', 'Age', 'OccupationID', 'Zip-code']
users = pd.read_csv('./ml-1m/users.dat', sep='::', header=None, names=users_title, engine = 'python')
users.head()




advertisement_title = ['AdvertisementID', 'Title', 'Genres']
advertisements = pd.read_csv('./ml-1m/advertisement.csv', sep='::', header=None, names=advertisement_title, engine = 'python')
advertisements.head()








ratings_title = ['UserID','AdvertisementID', 'Rating', 'timestamps']
ratings = pd.read_csv('./ml-1m/ratings.dat', sep='::', header=None, names=ratings_title, engine = 'python')
ratings.head()






def load_data():
    """
    Load Dataset from File
    """
    #读取User数据
    users_title = ['UserID', 'Gender', 'Age', 'JobID', 'Zip-code']
    users = pd.read_csv('./ml-1m/users.dat', sep='::', header=None, names=users_title, engine = 'python')
    users = users.filter(regex='UserID|Gender|Age|JobID')
    users_orig = users.values
    #改变User数据中性别和年龄
    gender_map = {'F':0, 'M':1}
    users['Gender'] = users['Gender'].map(gender_map)

    age_map = {val:ii for ii,val in enumerate(set(users['Age']))}
    users['Age'] = users['Age'].map(age_map)

    
    advertisements_title = ['AdvertisementID', 'Title', 'Genres']
    advertisements = pd.read_csv('./ml-1m/advertisement.csv', sep='::', header=None, names=advertisements_title, engine = 'python')
    advertisements_orig = advertisements.values
    #将Title中的年份去掉
    pattern = re.compile(r'^(.*)\((\d+)\)$')

    title_map = {val:pattern.match(val).group(1) for ii,val in enumerate(set(advertisements['Title']))}
    advertisements['Title'] = advertisements['Title'].map(title_map)


    genres_set = set()
    for val in advertisements['Genres'].str.split('|'):
        genres_set.update(val)

    genres_set.add('<PAD>')
    genres2int = {val:ii for ii, val in enumerate(genres_set)}


    genres_map = {val:[genres2int[row] for row in val.split('|')] for ii,val in enumerate(set(advertisements['Genres']))}

    for key in genres_map:
        for cnt in range(max(genres2int.values()) - len(genres_map[key])):
            genres_map[key].insert(len(genres_map[key]) + cnt,genres2int['<PAD>'])
    
    advertisements['Genres'] = advertisements['Genres'].map(genres_map)

   
    #读取评分数据集
    ratings_title = ['UserID','AdvertisementID', 'ratings', 'timestamps']
    ratings = pd.read_csv('./ml-1m/ratings.dat', sep='::', header=None, names=ratings_title, engine = 'python')
    ratings = ratings.filter(regex='UserID|AdvertisementID|ratings')

    #合并三个表
    data = pd.merge(pd.merge(ratings, users), advertisements)
    
    #将数据分成X和y两张表
    target_fields = ['ratings']
    features_pd, targets_pd = data.drop(target_fields, axis=1), data[target_fields]
    
    features = features_pd.values
    targets_values = targets_pd.values
    
    return genres2int, features, targets_values, ratings, users, advertisements, data, advertisements_orig, users_orig
genres2int





    {'Life-style': 0,
     'Advertising-song': 1,
     'Purchase-reason': 2,
     'Intuitive': 3,
     'Visual-effect': 4,
     'Emotional': 5,
     'Humor': 6,
     'Customer-recommend': 7,
     'Story': 8,
     'Pleasant': 9,
     'Passionate': 10,
     'Cartoon': 11,
     'Rational': 12,
     'Leben-passiert': 13,
     'Persuasive': 14,
     '<PAD>': 15,
     'Demonstration': 16,
     'Single-speaker': 17,
     'Film-Noir': 18}





genres2int, features, targets_values, ratings, users, advertisements, data, advertisements_orig, users_orig = load_data()

pickle.dump((genres2int, features, targets_values, ratings, users, advertisements, data, advertisements_orig, users_orig), open('preprocess.p', 'wb'))




advertisements.head()



advertisements.values[0]





    array([1, 'Toy Story ',
           list([17, 13, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15])],
          dtype=object)





genres2int, features, targets_values, ratings, users, advertisements, data, advertisements_orig, users_orig = pickle.load(open('preprocess.p', mode='rb'))




import tensorflow as tf
import os
import pickle

def save_params(params):
    """
    Save parameters to file
    """
    pickle.dump(params, open('params.p', 'wb'))


def load_params():
    """
    Load parameters from file
    """
    return pickle.load(open('params.p', mode='rb'))




#嵌入矩阵的维度
embed_dim = 32
#用户ID个数
uid_max = max(features.take(0,1)) + 1 # 6040
#性别个数
gender_max = max(features.take(2,1)) + 1 # 1 + 1 = 2
#年龄类别个数
age_max = max(features.take(3,1)) + 1 # 6 + 1 = 7
#职业个数
job_max = max(features.take(4,1)) + 1# 20 + 1 = 21


advertisement_id_max = max(features.take(1,1)) + 1 # 3952
#类型个数
advertisement_categories_max = max(genres2int.values()) + 1 # 18 + 1 = 19

combiner = "sum"


advertisementid2idx = {val[0]:i for i, val in enumerate(advertisements.values)}





    dict_values([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18])





# Number of Epochs
num_epochs = 5
# Batch Size
batch_size = 256

dropout_keep = 0.5
# Learning Rate
learning_rate = 0.0001
# Show stats for every n number of batches
show_every_n_batches = 20

save_dir = './save'




def get_inputs():
    uid = tf.placeholder(tf.int32, [None, 1], name="uid")
    user_gender = tf.placeholder(tf.int32, [None, 1], name="user_gender")
    user_age = tf.placeholder(tf.int32, [None, 1], name="user_age")
    user_job = tf.placeholder(tf.int32, [None, 1], name="user_job")
    
    advertisement_id = tf.placeholder(tf.int32, [None, 1], name="advertisement_id")
    advertisement_categories = tf.placeholder(tf.int32, [None, 18], name="advertisement_categories")
    targets = tf.placeholder(tf.int32, [None, 1], name="targets")
    LearningRate = tf.placeholder(tf.float32, name = "LearningRate")
    dropout_keep_prob = tf.placeholder(tf.float32, name = "dropout_keep_prob")
    return uid, user_gender, user_age, user_job, advertisement_id, advertisement_categories, targets, LearningRate, dropout_keep_prob




def get_user_embedding(uid, user_gender, user_age, user_job):
    with tf.name_scope("user_embedding"):
        uid_embed_matrix = tf.Variable(tf.random_uniform([uid_max, embed_dim], -1, 1), name = "uid_embed_matrix")
        uid_embed_layer = tf.nn.embedding_lookup(uid_embed_matrix, uid, name = "uid_embed_layer")
    
        gender_embed_matrix = tf.Variable(tf.random_uniform([gender_max, embed_dim // 2], -1, 1), name= "gender_embed_matrix")
        gender_embed_layer = tf.nn.embedding_lookup(gender_embed_matrix, user_gender, name = "gender_embed_layer")
        
        age_embed_matrix = tf.Variable(tf.random_uniform([age_max, embed_dim // 2], -1, 1), name="age_embed_matrix")
        age_embed_layer = tf.nn.embedding_lookup(age_embed_matrix, user_age, name="age_embed_layer")
        
        job_embed_matrix = tf.Variable(tf.random_uniform([job_max, embed_dim // 2], -1, 1), name = "job_embed_matrix")
        job_embed_layer = tf.nn.embedding_lookup(job_embed_matrix, user_job, name = "job_embed_layer")
    return uid_embed_layer, gender_embed_layer, age_embed_layer, job_embed_layer




def get_user_feature_layer(uid_embed_layer, gender_embed_layer, age_embed_layer, job_embed_layer):
    with tf.name_scope("user_fc"):
        #第一层全连接
        uid_fc_layer = tf.layers.dense(uid_embed_layer, embed_dim, name = "uid_fc_layer", activation=tf.nn.relu)
        gender_fc_layer = tf.layers.dense(gender_embed_layer, embed_dim, name = "gender_fc_layer", activation=tf.nn.relu)
        age_fc_layer = tf.layers.dense(age_embed_layer, embed_dim, name ="age_fc_layer", activation=tf.nn.relu)
        job_fc_layer = tf.layers.dense(job_embed_layer, embed_dim, name = "job_fc_layer", activation=tf.nn.relu)
        
        #第二层全连接
        user_combine_layer = tf.concat([uid_fc_layer, gender_fc_layer, age_fc_layer, job_fc_layer], 2)  #(?, 1, 128)
        user_combine_layer = tf.contrib.layers.fully_connected(user_combine_layer, 200, tf.tanh)  #(?, 1, 200)
    
        user_combine_layer_flat = tf.reshape(user_combine_layer, [-1, 200])
    return user_combine_layer, user_combine_layer_flat




def get_advertisement_id_embed_layer(advertisement_id):
    with tf.name_scope("advertisement_embedding"):
        advertisement_id_embed_matrix = tf.Variable(tf.random_uniform([advertisement_id_max, embed_dim], -1, 1), name = "advertisement_id_embed_matrix")
        advertisement_id_embed_layer = tf.nn.embedding_lookup(advertisement_id_embed_matrix, advertisement_id, name = "advertisement_id_embed_layer")
    return advertisement_id_embed_layer




def get_advertisement_categories_layers(advertisement_categories):
    with tf.name_scope("advertisement_categories_layers"):
        advertisement_categories_embed_matrix = tf.Variable(tf.random_uniform([advertisement_categories_max, embed_dim], -1, 1), name = "advertisement_categories_embed_matrix")
        advertisement_categories_embed_layer = tf.nn.embedding_lookup(advertisement_categories_embed_matrix, advertisement_categories, name = "advertisement_categories_embed_layer")
        if combiner == "sum":
            advertisement_categories_embed_layer = tf.reduce_sum(advertisement_categories_embed_layer, axis=1, keep_dims=True)
    #     elif combiner == "mean":

    return advertisement_categories_embed_layer




def get_advertisement_feature_layer(advertisement_id_embed_layer, advertisement_categories_embed_layer):
    with tf.name_scope("advertisement_fc"):
        #第一层全连接
        advertisement_id_fc_layer = tf.layers.dense(advertisement_id_embed_layer, embed_dim, name = "advertisement_id_fc_layer", activation=tf.nn.relu)
        advertisement_categories_fc_layer = tf.layers.dense(advertisement_categories_embed_layer, embed_dim, name = "advertisement_categories_fc_layer", activation=tf.nn.relu)
    
        #第二层全连接
        advertisement_combine_layer = tf.concat([advertisement_id_fc_layer, advertisement_categories_fc_layer], 2)  #(?, 1, 96)
        advertisement_combine_layer = tf.contrib.layers.fully_connected(advertisement_combine_layer, 200, tf.tanh)  #(?, 1, 200)
    
        advertisement_combine_layer_flat = tf.reshape(advertisement_combine_layer, [-1, 200])
    return advertisement_combine_layer, advertisement_combine_layer_flat




tf.reset_default_graph()
train_graph = tf.Graph()
with train_graph.as_default():
    #获取输入占位符
    uid, user_gender, user_age, user_job, advertisement_id, advertisement_categories, targets, lr, dropout_keep_prob = get_inputs()
    #获取User的4个嵌入向量
    uid_embed_layer, gender_embed_layer, age_embed_layer, job_embed_layer = get_user_embedding(uid, user_gender, user_age, user_job)
    #得到用户特征
    user_combine_layer, user_combine_layer_flat = get_user_feature_layer(uid_embed_layer, gender_embed_layer, age_embed_layer, job_embed_layer)

    advertisement_id_embed_layer = get_advertisement_id_embed_layer(advertisement_id)

    advertisement_categories_embed_layer = get_advertisement_categories_layers(advertisement_categories)

    advertisement_combine_layer, advertisement_combine_layer_flat = get_advertisement_feature_layer(advertisement_id_embed_layer, 
                                                                                advertisement_categories_embed_layer)
    #计算出评分，要注意两个不同的方案，inference的名字（name值）是不一样的，后面做推荐时要根据name取得tensor
    with tf.name_scope("inference"):

        inference = tf.reduce_sum(user_combine_layer_flat * advertisement_combine_layer_flat, axis=1)
        inference = tf.expand_dims(inference, axis=1)

    with tf.name_scope("loss"):
        # MSE损失，将计算值回归到评分
        cost = tf.losses.mean_squared_error(targets, inference )
        loss = tf.reduce_mean(cost)

    global_step = tf.Variable(0, name="global_step", trainable=False)
    optimizer = tf.train.AdamOptimizer(lr)
    gradients = optimizer.compute_gradients(loss)  #cost
    train_op = optimizer.apply_gradients(gradients, global_step=global_step)




inference





    <tf.Tensor 'inference/ExpandDims:0' shape=(?, 1) dtype=float32>





def get_batches(Xs, ys, batch_size):
    for start in range(0, len(Xs), batch_size):
        end = min(start + batch_size, len(Xs))
        yield Xs[start:end], ys[start:end]




%matplotlib inline
%config InlineBackend.figure_format = 'retina'
import matplotlib.pyplot as plt
import time
import datetime

losses = {'train':[], 'test':[]}

with tf.Session(graph=train_graph) as sess:
    
    #搜集数据给tensorBoard用
    # Keep track of gradient values and sparsity
    grad_summaries = []
    for g, v in gradients:
        if g is not None:
            grad_hist_summary = tf.summary.histogram("{}/grad/hist".format(v.name.replace(':', '_')), g)
            sparsity_summary = tf.summary.scalar("{}/grad/sparsity".format(v.name.replace(':', '_')), tf.nn.zero_fraction(g))
            grad_summaries.append(grad_hist_summary)
            grad_summaries.append(sparsity_summary)
    grad_summaries_merged = tf.summary.merge(grad_summaries)
        
    # Output directory for models and summaries
    timestamp = str(int(time.time()))
    out_dir = os.path.abspath(os.path.join(os.path.curdir, "runs", timestamp))
    print("Writing to {}\n".format(out_dir))
     
    # Summaries for loss and accuracy
    loss_summary = tf.summary.scalar("loss", loss)

    # Train Summaries
    train_summary_op = tf.summary.merge([loss_summary, grad_summaries_merged])
    train_summary_dir = os.path.join(out_dir, "summaries", "train")
    train_summary_writer = tf.summary.FileWriter(train_summary_dir, sess.graph)

    # Inference summaries
    inference_summary_op = tf.summary.merge([loss_summary])
    inference_summary_dir = os.path.join(out_dir, "summaries", "inference")
    inference_summary_writer = tf.summary.FileWriter(inference_summary_dir, sess.graph)

    sess.run(tf.global_variables_initializer())
    saver = tf.train.Saver()
    for epoch_i in range(num_epochs):
        
        #将数据集分成训练集和测试集，随机种子不固定
        train_X,test_X, train_y, test_y = train_test_split(features,  
                                                           targets_values,  
                                                           test_size = 0.2,  
                                                           random_state = 0)  
        
        train_batches = get_batches(train_X, train_y, batch_size)
        test_batches = get_batches(test_X, test_y, batch_size)
    
        #训练的迭代，保存训练损失
        for batch_i in range(len(train_X) // batch_size):
            x, y = next(train_batches)
            categories = np.zeros([batch_size, 18])
            for i in range(batch_size):
                categories[i] = x.take(6,1)[i]



            feed = {
                uid: np.reshape(x.take(0,1), [batch_size, 1]),
                user_gender: np.reshape(x.take(2,1), [batch_size, 1]),
                user_age: np.reshape(x.take(3,1), [batch_size, 1]),
                user_job: np.reshape(x.take(4,1), [batch_size, 1]),
                advertisement_id: np.reshape(x.take(1,1), [batch_size, 1]),
                advertisement_categories: categories,  #x.take(6,1)
#                 advertisement_titles: titles,  #x.take(5,1)
                targets: np.reshape(y, [batch_size, 1]),
                dropout_keep_prob: dropout_keep, #dropout_keep
                lr: learning_rate}

            step, train_loss, summaries, _ = sess.run([global_step, loss, train_summary_op, train_op], feed)  #cost
            losses['train'].append(train_loss)
            train_summary_writer.add_summary(summaries, step)  #
            
            # Show every <show_every_n_batches> batches
            if (epoch_i * (len(train_X) // batch_size) + batch_i) % show_every_n_batches == 0:
                time_str = datetime.datetime.now().isoformat()
                print('{}: Epoch {:>3} Batch {:>4}/{}   train_loss = {:.3f}'.format(
                    time_str,
                    epoch_i,
                    batch_i,
                    (len(train_X) // batch_size),
                    train_loss))
                
        #使用测试数据的迭代
        for batch_i  in range(len(test_X) // batch_size):
            x, y = next(test_batches)
            categories = np.zeros([batch_size, 18])
            for i in range(batch_size):
                categories[i] = x.take(6,1)[i]


            feed = {
                uid: np.reshape(x.take(0,1), [batch_size, 1]),
                user_gender: np.reshape(x.take(2,1), [batch_size, 1]),
                user_age: np.reshape(x.take(3,1), [batch_size, 1]),
                user_job: np.reshape(x.take(4,1), [batch_size, 1]),
                advertisement_id: np.reshape(x.take(1,1), [batch_size, 1]),
                advertisement_categories: categories,  #x.take(6,1)
                targets: np.reshape(y, [batch_size, 1]),
                dropout_keep_prob: 1,
                lr: learning_rate}
            
            step, test_loss, summaries = sess.run([global_step, loss, inference_summary_op], feed)  #cost

            #保存测试损失
            losses['test'].append(test_loss)
            inference_summary_writer.add_summary(summaries, step)  #

            time_str = datetime.datetime.now().isoformat()
            if (epoch_i * (len(test_X) // batch_size) + batch_i) % show_every_n_batches == 0:
                print('{}: Epoch {:>3} Batch {:>4}/{}   test_loss = {:.3f}'.format(
                    time_str,
                    epoch_i,
                    batch_i,
                    (len(test_X) // batch_size),
                    test_loss))

    # Save Model
    saver.save(sess, save_dir)  #, global_step=epoch_i
    print('Model Trained and Saved')


    




save_params((save_dir))

load_dir = load_params()




plt.plot(losses['train'], label='Training loss')
plt.legend()
_ = plt.ylim()



![png](output_24_0.png)




plt.plot(losses['test'], label='Test loss')
plt.legend()
_ = plt.ylim()



![png](output_25_0.png)




def get_tensors(loaded_graph):

    uid = loaded_graph.get_tensor_by_name("uid:0")
    user_gender = loaded_graph.get_tensor_by_name("user_gender:0")
    user_age = loaded_graph.get_tensor_by_name("user_age:0")
    user_job = loaded_graph.get_tensor_by_name("user_job:0")
    advertisement_id = loaded_graph.get_tensor_by_name("advertisement_id:0")
    advertisement_categories = loaded_graph.get_tensor_by_name("advertisement_categories:0")
    targets = loaded_graph.get_tensor_by_name("targets:0")
    dropout_keep_prob = loaded_graph.get_tensor_by_name("dropout_keep_prob:0")
    lr = loaded_graph.get_tensor_by_name("LearningRate:0")
    inference = loaded_graph.get_tensor_by_name("inference/ExpandDims:0") 
    advertisement_combine_layer_flat = loaded_graph.get_tensor_by_name("advertisement_fc/Reshape:0")
    user_combine_layer_flat = loaded_graph.get_tensor_by_name("user_fc/Reshape:0")
    return uid, user_gender, user_age, user_job, advertisement_id, advertisement_categories,targets, lr, dropout_keep_prob, inference, advertisement_combine_layer_flat, user_combine_layer_flat






def rating_advertisement(user_id_val, advertisement_id_val):
    loaded_graph = tf.Graph()  #
    with tf.Session(graph=loaded_graph) as sess:  #
        # Load saved model
        loader = tf.train.import_meta_graph(load_dir + '.meta')
        loader.restore(sess, load_dir)
    
        # Get Tensors from loaded model
        uid, user_gender, user_age, user_job, advertisement_id, advertisement_categories,targets, lr, dropout_keep_prob, inference,_, __ = get_tensors(loaded_graph)  #loaded_graph
    
        categories = np.zeros([1, 18])
        categories[0] = advertisements.values[advertisementid2idx[advertisement_id_val]][2]
    
    
        feed = {
              uid: np.reshape(users.values[user_id_val-1][0], [1, 1]),
              user_gender: np.reshape(users.values[user_id_val-1][1], [1, 1]),
              user_age: np.reshape(users.values[user_id_val-1][2], [1, 1]),
              user_job: np.reshape(users.values[user_id_val-1][3], [1, 1]),
              advertisement_id: np.reshape(advertisements.values[advertisementid2idx[advertisement_id_val]][0], [1, 1]),
              advertisement_categories: categories,  #x.take(6,1)
              dropout_keep_prob: 1}
    
        # Get Prediction
        inference_val = sess.run([inference], feed)  
    
        return (inference_val)




rating_advertisement(234, 1401)


    INFO:tensorflow:Restoring parameters from ./save





    [array([[3.9777853]], dtype=float32)]





loaded_graph = tf.Graph()  #
advertisement_matrics = []
with tf.Session(graph=loaded_graph) as sess:  #
    # Load saved model
    loader = tf.train.import_meta_graph(load_dir + '.meta')
    loader.restore(sess, load_dir)

    # Get Tensors from loaded model
    uid, user_gender, user_age, user_job, advertisement_id, advertisement_categories, targets, lr, dropout_keep_prob, _, advertisement_combine_layer_flat, __ = get_tensors(loaded_graph)  #loaded_graph

    for item in advertisements.values:
        categories = np.zeros([1, 18])
        categories[0] = item.take(2)


        feed = {
            advertisement_id: np.reshape(item.take(0), [1, 1]),
            advertisement_categories: categories,  #x.take(6,1)
            dropout_keep_prob: 1}

        advertisement_combine_layer_flat_val = sess.run([advertisement_combine_layer_flat], feed)  
        advertisement_matrics.append(advertisement_combine_layer_flat_val)

pickle.dump((np.array(advertisement_matrics).reshape(-1, 200)), open('advertisement_matrics.p', 'wb'))
advertisement_matrics = pickle.load(open('advertisement_matrics.p', mode='rb'))


    INFO:tensorflow:Restoring parameters from ./save




advertisement_matrics = pickle.load(open('advertisement_matrics.p', mode='rb'))




loaded_graph = tf.Graph()  #
users_matrics = []
with tf.Session(graph=loaded_graph) as sess:  #
    # Load saved model
    loader = tf.train.import_meta_graph(load_dir + '.meta')
    loader.restore(sess, load_dir)

    # Get Tensors from loaded model
    uid, user_gender, user_age, user_job, movie_id, movie_categories, targets, lr, dropout_keep_prob, _, __,user_combine_layer_flat = get_tensors(loaded_graph)  #loaded_graph

    for item in users.values:

        feed = {
            uid: np.reshape(item.take(0), [1, 1]),
            user_gender: np.reshape(item.take(1), [1, 1]),
            user_age: np.reshape(item.take(2), [1, 1]),
            user_job: np.reshape(item.take(3), [1, 1]),
            dropout_keep_prob: 1}

        user_combine_layer_flat_val = sess.run([user_combine_layer_flat], feed)  
        users_matrics.append(user_combine_layer_flat_val)

pickle.dump((np.array(users_matrics).reshape(-1, 200)), open('users_matrics.p', 'wb'))
users_matrics = pickle.load(open('users_matrics.p', mode='rb'))


    INFO:tensorflow:Restoring parameters from ./save




users_matrics = pickle.load(open('users_matrics.p', mode='rb'))




def recommend_same_type_movie(advertisement_id_val, top_k = 20):
    
    loaded_graph = tf.Graph()  #
    with tf.Session(graph=loaded_graph) as sess:  #
        # Load saved model
        loader = tf.train.import_meta_graph(load_dir + '.meta')
        loader.restore(sess, load_dir)
        
        norm_advertisement_matrics = tf.sqrt(tf.reduce_sum(tf.square(advertisement_matrics), 1, keep_dims=True))
        normalized_advertisement_matrics = advertisement_matrics / norm_advertisement_matrics

        probs_embeddings = (advertisement_matrics[advertisementid2idx[advertisement_id_val]]).reshape([1, 200])
        probs_similarity = tf.matmul(probs_embeddings, tf.transpose(normalized_advertisement_matrics))
        sim = (probs_similarity.eval())
    #     results = (-sim[0]).argsort()[0:top_k]
    #     print(results)
        
        print("您看的广告是：{}".format(advertisements_orig[advertisementid2idx[advertisement_id_val]]))
        print("以下是给您的推荐：")
        p = np.squeeze(sim)
        p[np.argsort(p)[:-top_k]] = 0
        p = p / np.sum(p)
        results = set()
        while len(results) != 5:
            c = np.random.choice(3883, 1, p=p)[0]
            results.add(c)
        for val in (results):
            print(val)
            print(advertisements_orig[val])
        
        return results




recommend_same_type_movie(1401, 5)


    INFO:tensorflow:Restoring parameters from ./save
    您看的广告是：[1401 'Visual-effect']
    以下是给您的推荐：
    
    1380
    [1401 'Visual-effect']
    3229
    [3298 'Visual-effect']
    3734
    [3803 'Visual-effect']
    2268
    [2337  'Visual-effect']
    2173
    [2242  'Visual-effect']





    {1380, 2173, 2268, 3229, 3734}





def recommend_your_favorite_advertisement(user_id_val, top_k = 5):

    loaded_graph = tf.Graph()  #
    with tf.Session(graph=loaded_graph) as sess:  #
        # Load saved model
        loader = tf.train.import_meta_graph(load_dir + '.meta')
        loader.restore(sess, load_dir)

        probs_embeddings = (users_matrics[user_id_val-1]).reshape([1, 200])

        probs_similarity = tf.matmul(probs_embeddings, tf.transpose(advertisement_matrics))
        sim = (probs_similarity.eval())
        print(sim)
    
        print("以下是给您的推荐：")
        p = np.squeeze(sim)
        p[np.argsort(p)[:-top_k]] = 0
        p = p / np.sum(p)
        results = set()
        while len(results) != 5:
            c = np.random.choice(3883, 1, p=p)[0]
            results.add(c)
        for val in (results):
            print(val)
            print(advertisements_orig[val])

        return results




recommend_your_favorite_advertisement(234, 5)


    以下是给您的推荐：
    3492
    [3561  'Visual-effect']
    2864
    [2933  'Visual-effect']
    2961
    [3030  'Life-style|Visual-effect|Intuitive']
    861
    [872   'Visual-effect']
    1950
    [2019 'Demonstration|Visual-effect']

    {861, 1950, 2864, 2961, 3492}



import random

def recommend_other_favorite_advertisement(advertisement_id_val, top_k = 20):
    loaded_graph = tf.Graph()  #
    with tf.Session(graph=loaded_graph) as sess:  #
        # Load saved model
        loader = tf.train.import_meta_graph(load_dir + '.meta')
        loader.restore(sess, load_dir)

        probs_advertisement_embeddings = (advertisement_matrics[advertisementid2idx[advertisement_id_val]]).reshape([1, 200])
        probs_user_favorite_similarity = tf.matmul(probs_advertisement_embeddings, tf.transpose(users_matrics))
        favorite_user_id = np.argsort(probs_user_favorite_similarity.eval())[0][-top_k:]
    #     print(normalized_users_matrics.eval().shape)
    #     print(probs_user_favorite_similarity.eval()[0][favorite_user_id])
    #     print(favorite_user_id.shape)
    
        print("您看的广告是：{}".format(advertisements_orig[advertisementid2idx[advertisement_id_val]]))
        
        print("喜欢看这个广告的人是：{}".format(users_orig[favorite_user_id-1]))
        probs_users_embeddings = (users_matrics[favorite_user_id-1]).reshape([-1, 200])
        probs_similarity = tf.matmul(probs_users_embeddings, tf.transpose(advertisement_matrics))
        sim = (probs_similarity.eval())
    #     results = (-sim[0]).argsort()[0:top_k]
    #     print(results)
    
    #     print(sim.shape)
    #     print(np.argmax(sim, 1))
        p = np.argmax(sim, 1)
        print("喜欢看这个广告的人还喜欢看：")

        results = set()
        while len(results) != 5:
            c = p[random.randrange(top_k)]
            results.add(c)
        for val in (results):
            print(val)
            print(advertisements_orig[val])
        
        return results




recommend_other_favorite_advertisement(1401, 20)


    INFO:tensorflow:Restoring parameters from ./save
    您看的广告是：[1401 'Visual-effect']
    喜欢看这个广告的人是：[[1763 'M' 35 7]
     [1131 'M' 56 13]
     [3833 'M' 25 1]
     [1745 'M' 45 0]
     [1855 'M' 18 4]
     [4134 'F' 45 12]
     [1701 'F' 25 4]
     [1053 'M' 35 0]
     [1672 'M' 25 17]
     [3603 'F' 35 7]
     [2338 'M' 45 17]
     [3031 'M' 18 4]
     [2693 'M' 56 13]
     [209 'M' 35 1]
     [5861 'F' 50 1]
     [371 'M' 18 4]
     [4085 'F' 25 6]
     [4800 'M' 18 4]
     [100 'M' 35 17]
     [3901 'M' 18 14]]
    喜欢看这个广告的人还喜欢看：
    1442
    [1470 'Advertising-song']
    676
    [683 'Advertising-song']
    847
    [858  'Demonstration|Cartoon|Visual-effect']
    49
    [50 'Cartoon|Passionate']
    1950
    [2019 'Demonstration|Visual-effect']

    {49, 676, 847, 1442, 1950}







