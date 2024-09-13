from django.http import HttpResponse
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.db import connection





# views.py

def homePage(request):
    data={}
    try:    
        username = request.session.get('userInfo')['username']
        print(username)
        sql_query2 = "SELECT * FROM Genres"
        with connection.cursor() as cursor:
                    cursor.execute(sql_query2)
                    rowsGenres = cursor.fetchall()
                    data = {
                        'genres': rowsGenres
    
                    }
                    allMovies = {}
                    for genre in data['genres']:
                        sql_query = "CALL get_genre_movies(%s,%s)"
                        cursor.execute(sql_query,[genre[0],username])
                        rows = cursor.fetchall()
                        allMovies[genre[0]] = rows
                    data['movies'] = allMovies

        if(request.method == "POST"):
            if('searchButton' in request.POST):
                data_to_pass = {
                    'prompt': request.POST.get('search')
                }

                request.session['searchPrompt'] =  data_to_pass
                return HttpResponseRedirect('/search/')
            else:
                data_to_pass = {
                    'movie_title': request.POST.get('movie_title')
                }
                watchHistoryInsert ='CALL insert_watchHistory(%s,%s)'
                with connection.cursor() as cursor:
                    cursor.execute(watchHistoryInsert,[username,data_to_pass['movie_title']])
                
                request.session['data'] =  data_to_pass
                return HttpResponseRedirect('/movie/'+data_to_pass['movie_title'])
    except:
        pass
    return render(request, 'home.html',data)

def signUpPage(request):
    errorInfo={}
    try:
        if request.method=="POST":
            username = request.POST.get('username')
            email = request.POST.get('email')
            password = request.POST.get('password')
            firstname = request.POST.get('firstName')
            lastname = request.POST.get('lastName')
            dob = request.POST.get('dob')
            gender = request.POST.get('gender')
            contactno = request.POST.get('contactno')
           
            sql_query = "SELECT * FROM User WHERE username = %s"
            with connection.cursor() as cursor:
                cursor.execute(sql_query,[username])
                if(cursor.rowcount > 0):
                    errorInfo['error'] = True   
                else:
                     errorInfo['error'] = False
                     data_to_pass = {
                    'username': username,
                    'email': email,
                    'password': password,
                    'firstname': firstname,
                    'lastname': lastname,
                    'dob': dob,
                    'gender':gender,
                    'contactno': contactno,
                    }
                     request.session['userInfo'] = data_to_pass
                     return HttpResponseRedirect('/subscription/')
                    
    except:
        pass
    return render(request, 'signup.html',errorInfo)
                    



def subscriptionPage(request):
    try:
        if request.method=="POST":
            accType = request.POST.get('accType')
            data_to_pass = request.session['userInfo']
            data_to_pass['accType'] = accType
            request.session['userInfo'] = data_to_pass
            
            return HttpResponseRedirect('/creditcard/')
    except:
        pass
    return render(request, 'subscription.html')





def creditcardPage(request):
    try:
        if request.method == "POST":
            data_to_pass = request.session.get('userInfo')  
            cardno = request.POST.get('cardNum')
            expiry = request.POST.get('expiry')
            cvv = request.POST.get('cvv')
            print(1)
            sql_query = """
                INSERT INTO `User` (username, fname, lname, `password`, email, contact_no, date_of_birth, account_type, credit_info_valid_to, credit_info_cvv, credit_info_card_no)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            
            if(data_to_pass['accType'] == '1'):
                data_to_pass['accType'] = "Standard"
            elif(data_to_pass['accType'] == '2'):
                data_to_pass['accType'] = "Premium"
            elif(data_to_pass['accType'] == '3'):
                data_to_pass['accType'] = "Executive"
            else:   
                print("Invalid account type")

            #sql_query2 = "SELECT * FROM User"
            with connection.cursor() as cursor:
                print(data_to_pass)
                print(expiry)
                print(int(cvv))
                print(cardno)
                cursor.execute(sql_query, [
                    data_to_pass['username'],
                    data_to_pass['firstname'],
                    data_to_pass['lastname'],
                    data_to_pass['password'],
                    data_to_pass['email'],
                    data_to_pass['contactno'],
                    data_to_pass['dob'],
                    data_to_pass['accType'],
                    expiry,
                    int(cvv),
                    cardno
                ])
                print(3)
            
            # If execution is successful, redirect to a success page
            return HttpResponseRedirect('/home/')
    
    except:
      pass

    return render(request, 'creditcard.html')



def loginPage(request):
    request.session.flush()
    errorInfo={}
    try:
        if request.method=="POST":
            username = request.POST.get('username')
            password = request.POST.get('password')
            user_data = {
                'username': username,
                'password': password
            }
            request.session['userInfo'] = user_data
            sql_query = "SELECT * FROM User WHERE username = %s AND password = %s"
            with connection.cursor() as cursor:
                cursor.execute(sql_query,[username,password])
                if(cursor.rowcount > 0):
                    errorInfo['error'] = False
                    return HttpResponseRedirect('/home/')
                else:
                    errorInfo['error'] = True
    except:
        pass
    return render(request, 'login.html',errorInfo)



def listPage(request):
    data = {}
    try:  
        username = request.session.get('userInfo')['username']
        sql_query = "CALL get_favorites(%s,%s)"
        with connection.cursor() as cursor:
                    cursor.execute(sql_query,[username,username])
                    rowsMovie = cursor.fetchall()
                    data = {
                        'movies': rowsMovie,
                    }
        if(request.method == "POST"):
            if('searchButton' in request.POST):
                username = request.POST.get('search')
                request.session['usernameList'] =  username
                return HttpResponseRedirect('/othersList/')
            else:
                data_to_pass = {
                    'movie_title': request.POST.get('movie_title')
                }
                watchHistoryInsert ='CALL insert_watchHistory(%s,%s)'
                with connection.cursor() as cursor:
                    cursor.execute(watchHistoryInsert,[username,data_to_pass['movie_title']])
                request.session['data'] =  data_to_pass
                return HttpResponseRedirect('/movie/'+data_to_pass['movie_title'])
    except:
        pass
    return render(request, 'list.html',data)

def othersListPage(request):
    data={}
    try:  
        data['exists'] = 1
        currUser = request.session.get('userInfo')['username']
        username = request.session.get('usernameList')
        checkuser = 'SELECT * FROM `User` WHERE username =%s'
        sql_query = "CALL get_favorites(%s,%s)"
        with connection.cursor() as cursor:
                cursor.execute(checkuser,[username])
                if(cursor.rowcount != 0):
            
                    cursor.execute(sql_query,[username,currUser])
                    rowsMovie = cursor.fetchall()
                
                    data = {
                        'movies': rowsMovie,
                        'username': username,
                        'exists': 1,
                    }
                else:
                    data['exists'] = 0
        if(request.method == "POST"):
            if('searchButton' in request.POST):
                username = request.POST.get('search')
                request.session['usernameList'] =  username
                return HttpResponseRedirect('/othersList/')
            else:
                data_to_pass = {
                    'movie_title': request.POST.get('movie_title')
                }
                watchHistoryInsert ='CALL insert_watchHistory(%s,%s)'
                with connection.cursor() as cursor:
                    cursor.execute(watchHistoryInsert,[currUser,data_to_pass['movie_title']])
                request.session['data'] =  data_to_pass
                return HttpResponseRedirect('/movie/'+data_to_pass['movie_title'])
    except:
        pass
    return render(request, 'othersList.html',data)



def searchPage(request):
    try:  
        prompt = request.session.get('searchPrompt')['prompt'] 
        username = request.session.get('userInfo')['username'] 
        sql_query = "CALL prompt_result(%s,%s)"
        sql_query2 = "CALL genre_result(%s,%s)"
        with connection.cursor() as cursor:
                    cursor.execute(sql_query,[prompt,username])
                    rowsMovie = cursor.fetchall()
                    cursor.execute(sql_query2,[prompt,username])
                    rowsGenre = cursor.fetchall()
                    data = {
                        'movies': rowsMovie,
                        'genre' : rowsGenre,
                        'prompt': prompt
                    }
        if(request.method == "POST"):
            if('searchButton' in request.POST):
                data_to_pass = {
                    'prompt': request.POST.get('search')
                }

                request.session['searchPrompt'] =  data_to_pass
                return HttpResponseRedirect('/search/')
            else:
                data_to_pass = {
                    'movie_title': request.POST.get('movie_title')
                }
                watchHistoryInsert ='CALL insert_watchHistory(%s,%s)'
                with connection.cursor() as cursor:
                    cursor.execute(watchHistoryInsert,[username,data_to_pass['movie_title']])
                request.session['data'] =  data_to_pass
                return HttpResponseRedirect('/movie/'+data_to_pass['movie_title'])
    except:
        pass
    return render(request, 'search.html', data)  



def moviePage(request, movieTitle):
    data={}
    title = request.session.get('data')['movie_title']
    sql_query = "SELECT * FROM Movie WHERE title = %s"
    sql_query2 = "SELECT movieGenre FROM MovieGenre WHERE movieTitle = %s"
    sql_query6 = "SELECT * FROM Favourites WHERE user_name = %s AND movie_name = %s"
    with connection.cursor() as cursor:
        cursor.execute(sql_query,[title])
        rowM = cursor.fetchone()
        cursor.execute(sql_query2,[title])
        rowMG = cursor.fetchall()
        data = {
                'movie': rowM,
                'genres': rowMG,
            }
        cursor.execute(sql_query6,[request.session.get('userInfo')['username'], title])
        if(cursor.rowcount > 0):
           data['added'] = True
        else:
            data['added'] = False
    try:
        if request.method == "POST":
            data_to_pass = request.session.get('userInfo')
            sql_query3 = "SELECT * FROM Favourites WHERE user_name = %s AND movie_name = %s"
            with connection.cursor() as cursor:
                cursor.execute(sql_query3,[data_to_pass['username'], title])
                if(cursor.rowcount == 0):
                    sql_query4 = "INSERT INTO Favourites (user_name, movie_name) VALUES (%s, %s)"
                    cursor.execute(sql_query4,[data_to_pass['username'], title])
                    data['added'] = True
                else:
                    sql_query5 = "DELETE FROM Favourites WHERE user_name = %s AND movie_name = %s"
                    cursor.execute(sql_query5,[data_to_pass['username'], title])   
                    data['added'] = False 


            
    except:
        pass    

    return render(request, 'movie.html',data)

def watchHistoryPage(request):
    data = {}
    try:  
        username = request.session.get('userInfo')['username'] 
        sql_query = "call get_watchHistory(%s)"
        with connection.cursor() as cursor:
                    cursor.execute(sql_query,[username])
                    rowsMovie = cursor.fetchall()
                    data = {
                        'movies': rowsMovie,
                    }
        if(request.method == "POST"):
            if('searchButton' in request.POST):
                data_to_pass = {
                    'prompt': request.POST.get('search')
                }

                request.session['searchPrompt'] =  data_to_pass
                return HttpResponseRedirect('/search/')
            else:
                data_to_pass = {
                    'movie_title': request.POST.get('movie_title')
                }

                request.session['data'] =  data_to_pass
                return HttpResponseRedirect('/movie/'+data_to_pass['movie_title'])
    except:
        pass
    return render(request, 'watchhistory.html',data)