/*
 * Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
 */
package org.hybris.training.controllers;

import de.hybris.platform.core.servicelayer.data.SearchPageData;
import de.hybris.platform.webservicescommons.cache.CacheControl;
import de.hybris.platform.webservicescommons.cache.CacheControlDirective;
import de.hybris.platform.webservicescommons.constants.WebservicescommonsConstants;
import de.hybris.platform.webservicescommons.errors.exceptions.WebserviceValidationException;
import de.hybris.platform.webservicescommons.mapping.DataMapper;
import de.hybris.platform.webservicescommons.pagination.WebPaginationUtils;
import de.hybris.platform.webservicescommons.swagger.ApiFieldsParam;
import de.hybris.platform.webservicescommons.util.YSanitizer;

import javax.annotation.Resource;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.google.common.collect.Sets;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.Authorization;
import jersey.repackaged.com.google.common.collect.Lists;
import org.hybris.training.data.UserData;
import org.hybris.training.data.UserDataList;
import org.hybris.training.dto.SampleWsDTO;
import org.hybris.training.dto.TestMapWsDTO;
import org.hybris.training.dto.UserWsDTO;
import org.hybris.training.dto.UsersListWsDTO;
import org.hybris.training.dto.UsersPageWsDTO;
import org.hybris.training.facades.SampleFacades;

import static org.hybris.training.constants.TrainingwebservicesConstants.CLIENT_CREDENTIAL_AUTHORIZATION_NAME;
import static org.hybris.training.constants.TrainingwebservicesConstants.PASSWORD_AUTHORIZATION_NAME;
import static org.hybris.training.constants.TrainingwebservicesConstants.SAMPLE_LIST_DOUBLE_VALUE;
import static org.hybris.training.constants.TrainingwebservicesConstants.SAMPLE_LIST_STRING_VALUE;


/**
 * Sample Controller
 */
@Controller
@RequestMapping(value = "/sample")
@Api(tags = "Sample")
public class SampleController
{
	public static final String DEFAULT_FIELD_SET = "DEFAULT";

	@Resource
	private SampleFacades sampleFacades;

	@Resource(name = "sampleWsDTOValidator")
	private Validator sampleWsDTOValidator;

	@Resource(name = "dataMapper")
	private DataMapper dataMapper;

	@Resource
	private WebPaginationUtils webPaginationUtils;

	@Autowired(required = false)
	private SampleWsDTO testBean;

	/**
	 * Sample method returning Cache-Control header and using Path Variable</br>
	 * Example :</br>
	 * GET http://localhost:9001/trainingwebservices/sample/dto/sampleValue
	 *
	 * @param pathVariable - sample path variable parameter
	 * @return SampleWsDTO object filled with pathVariable value
	 */
	@GetMapping(value = "/dto/{pathVariable}")
	@CacheControl(directive = CacheControlDirective.PUBLIC, maxAge = 1800)
	@ResponseBody
	@ApiOperation(nickname = "getSample", value = "Method with path parameter returns sample DTO", notes = "Sample method returning Cache-Control header and using Path Variable", produces = "application/json,application/xml", authorizations = {
			@Authorization(value = CLIENT_CREDENTIAL_AUTHORIZATION_NAME), @Authorization(value = PASSWORD_AUTHORIZATION_NAME) })
	public SampleWsDTO getSample(
			@ApiParam(value = "Sample path variable parameter. It should be returned in response DTO", required = true) @PathVariable final String pathVariable)
	{
		return sampleFacades.getSampleWsDTO(YSanitizer.sanitize(pathVariable));
	}

	/**
	 * Sample method showing how to validate object given in POST body parameter<br/>
	 * Example :</br>
	 * URL : http://localhost:9001/trainingwebservices/sample/dto</br>
	 * Method : POST</br>
	 * Header : Content-Type=application/json</br>
	 * POST body parameter :{ "value" : "sampleValue"}</br>
	 *
	 * @param sampleWsDTO - Request body parameter (DTO in xml or json format)</br>
	 * @return - The same object, which was send in POST body</br>
	 */
	@PostMapping(value = "/dto")
	@ResponseStatus(HttpStatus.CREATED)
	@ResponseBody
	@ApiOperation(nickname = "createSample", value = "Method with body parameter", notes = "Sample method handling POST body parameter", produces = "application/json,application/xml", consumes = "application/json,application/xml", authorizations = {
			@Authorization(value = CLIENT_CREDENTIAL_AUTHORIZATION_NAME), @Authorization(value = PASSWORD_AUTHORIZATION_NAME) })
	public SampleWsDTO createSample(
			@ApiParam(value = "Sample request body parameter (DTO in xml or json format). It should be returned as response DTO", required = true) @RequestBody final SampleWsDTO sampleWsDTO)
	{
		validate(sampleWsDTO, "sampleWsDTO", sampleWsDTOValidator);
		return sampleWsDTO;
	}

	protected void validate(final Object object, final String objectName, final Validator validator)
	{
		final Errors errors = new BeanPropertyBindingResult(object, objectName);
		validator.validate(object, errors);
		if (errors.hasErrors())
		{
			throw new WebserviceValidationException(errors);
		}
	}

	/**
	 * Request handler for list response. Retrieves all user from userService and maps Collection of UserModel to
	 * UserListWsDTO Mapping is done according to configuration in WEB-INF/config/field-mapping.xml Sample url's:
	 * <ul>
	 * <li>http://localhost:9001/trainingwebservices/sample/users
	 * <li>http://localhost:9001/trainingwebservices/sample/users?fields=users(info)
	 * <li>http://localhost:9001/trainingwebservices/sample/users?fields=users(BASIC)
	 * <li>http://localhost:9001/trainingwebservices/sample/users?fields=users(DEFAULT)
	 * <li>http://localhost:9001/trainingwebservices/sample/users?fields=users(FULL)
	 * <li>http://localhost:9001/trainingwebservices/sample/users?fields=users(firstName,addresses(street))
	 * </ul>
	 */
	@GetMapping(value = "/users")
	@ResponseBody
	@ApiOperation(nickname = "getUsersList", value = "Get users", notes = "Sample method returning user list.", produces = "application/json,application/xml", authorizations = {
			@Authorization(value = CLIENT_CREDENTIAL_AUTHORIZATION_NAME), @Authorization(value = PASSWORD_AUTHORIZATION_NAME) })
	public UsersListWsDTO getUsersList(
			@ApiFieldsParam(examples = "users(firstName,addresses(street)") @RequestParam(required = false, defaultValue = DEFAULT_FIELD_SET) final String fields)
	{
		final List<UserData> users = sampleFacades.getUsers();
		final UserDataList userList = new UserDataList();
		userList.setUsers(users);
		return dataMapper.map(userList, UsersListWsDTO.class, fields);
	}

	/**
	 * Request handler for paginated response. Retrieves user from userService and maps result to UsersPageWsDTO Mapping is
	 * done according to configuration in WEB-INF/config/field-mapping.xml Sample url's:
	 * <ul>
	 * <li>http://localhost:9001/trainingwebservices/sample/usersPaged
	 * <li>http://localhost:9001/trainingwebservices/sample/usersPaged?currentPage=1
	 * <li>http://localhost:9001/trainingwebservices/sample/usersPaged?currentPage=0?pageSize=1
	 * </ul>
	 */
	@GetMapping(value = "/usersPaged")
	@ResponseBody
	@ApiOperation(nickname = "getUsers", value = "Get users", notes = "Sample method returning user page.", produces = "application/json,application/xml", authorizations = {
			@Authorization(value = CLIENT_CREDENTIAL_AUTHORIZATION_NAME), @Authorization(value = PASSWORD_AUTHORIZATION_NAME) })
	@ApiImplicitParams({
			@ApiImplicitParam(name = WebservicescommonsConstants.PAGE_SIZE, value = "Page size", required = false, dataType = "int", paramType = "query"),
			@ApiImplicitParam(name = WebservicescommonsConstants.CURRENT_PAGE, value = "Current page number", required = false, dataType = "int", paramType = "query"),
			@ApiImplicitParam(name = WebservicescommonsConstants.NEEDS_TOTAL, value = "Request total count", required = false, dataType = "boolean", paramType = "query") })
	public UsersPageWsDTO getUsers(
			@ApiFieldsParam @RequestParam(required = false, defaultValue = DEFAULT_FIELD_SET) final String fields,
			@ApiParam(hidden = true) @RequestParam final Map<String, String> params)
	{
		final SearchPageData<Object> pageData = webPaginationUtils.buildSearchPageData(params);

		final SearchPageData<UserData> users = sampleFacades.getUsers(pageData);
		return dataMapper.map(users, UsersPageWsDTO.class, fields);
	}

	/**
	 * Request handler for particular user. Retrieves single user from userService and maps UserModel to UserWsDTO Mapping
	 * is done according to configuration in WEB-INF/config/field-mapping.xml Sample url's:
	 * <ul>
	 * <li>http://localhost:9001/trainingwebservices/sample/users/user1
	 * <li>http://localhost:9001/trainingwebservices/sample/users/user1?fields=info
	 * <li>http://localhost:9001/trainingwebservices/sample/users/user1?fields=BASIC
	 * <li>http://localhost:9001/trainingwebservices/sample/users/user1?fields=DEFAULT
	 * <li>http://localhost:9001/trainingwebservices/sample/users/user1?fields=FULL
	 * <li>http://localhost:9001/trainingwebservices/sample/users/user1?fields=firstName,addresses(street)
	 * </ul>
	 */
	@GetMapping(value = "/users/{id}")
	@ResponseBody
	@ApiOperation(nickname = "getUser", value = "Get user information", notes = "Sample method returning user information. Operation permitted for ROLE_CLIENT", produces = "application/json,application/xml", authorizations = {
			@Authorization(value = CLIENT_CREDENTIAL_AUTHORIZATION_NAME) })
	public UserWsDTO getUser(@ApiParam(value = "User identifier", required = true) @PathVariable final String id,
			@ApiFieldsParam(examples = "firstName,addresses(street)") @RequestParam(required = false, defaultValue = DEFAULT_FIELD_SET) final String fields)
	{
		final UserData data = sampleFacades.getUser(id);
		return dataMapper.map(data, UserWsDTO.class, fields);
	}

	/**
	 * Request handler for getting object with map. Created to test adapters for particular fields.
	 * <p>
	 * Url: http://localhost:9001/trainingwebservices/sample/map
	 */
	@GetMapping(value = "/map")
	@ResponseBody
	@ApiOperation(nickname = "getTestMap", value = "Get object with map inside", notes = "Sample method returning object with map.", produces = "application/json,application/xml")
	public TestMapWsDTO getTestMap()
	{
		return sampleFacades.getMap();
	}


	@PostMapping(value = "plain/string")
	@ResponseBody
	@ApiOperation(nickname = "doProcessString", value = "Process String object", notes = "Sample method returning string object")
	public String doProcessString(
			@ApiParam(value = "Request parameter which will be changed to response string", required = true) @RequestBody final String val)
	{
		return YSanitizer.sanitize(val) + "1";
	}


	@PostMapping(value = "plain/long")
	@ResponseBody
	@ApiOperation(nickname = "doProcessLong", value = "Process Long object", notes = "Sample method returning Long object")
	public Long doProcessLong(
			@ApiParam(value = "Request param which will be used to calculate response value", required = true) @RequestBody final Long value)
	{
		return value + 1L;
	}


	@PostMapping(value = "plain/double")
	@ResponseBody
	@ApiOperation(nickname = "doProcessDouble", value = "Process Double object", notes = "Sample method returning string object")
	public double doProcessDouble(
			@ApiParam(value = "Request param which will be used to calculate response value", required = true) @RequestBody final double value)
	{
		return value + 1;
	}


	@GetMapping(value = "plain/list")
	@ResponseBody
	@ApiOperation(nickname = "getList", value = "Get list object", notes = "Sample method returning list object.")
	public List<Object> getList()
	{
		return Lists.newArrayList(SAMPLE_LIST_STRING_VALUE, SAMPLE_LIST_DOUBLE_VALUE);
	}

	@GetMapping(value = "plain/map")
	@ResponseBody
	@ApiOperation(nickname = "getMap", value = "Get map object", notes = "Sample method returning map object.")
	public Map<String, Object> getMap()
	{
		final Map<String, Object> map = new HashMap<>();
		map.put("a", "Ala");
		map.put("b", 1);
		map.put("c", Sets.newHashSet("a", "b", "c"));
		return map;
	}

	@GetMapping(value = "/testBean")
	@ResponseBody
	@ApiOperation(nickname = "getTestBeanText", value = "Get bean object", notes = "Sample method returning bean object.")
	public SampleWsDTO getTestBeanText()
	{
		return testBean;
	}
}
